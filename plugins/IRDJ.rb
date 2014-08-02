require 'cinch'
require 'thread'
require 'vlc-client'

class IRDJ
    include Cinch::Plugin
    @prefix = //
    @suffix = //

    match /^((!songs)|(!songrequest))$/, method: :song_help
    match /^!songrequest (.+)$/, method: :song_req

    $vlc_q = Queue.new

    vlcworker = Thread.new do
        #Start server and connect
        vlc = VLC::System.new
        vlc.connected?
        loop do
            song = $vlc_q.pop
            info "QUEUED:#{song}"
            vlc.play song
            sleep 1 until vlc.stopped?
        end
    end

    def song_help(m)
        m.reply "Use !songrequest [Youtube/Soundcloud/mp3/etc. URL] to request a song."
    end

    def song_req(m, link)
        info "RAW:#{link}"
        $vlc_q << process(link)
    end

    def process(link)
        link = "http://#{link}" unless link =~ /http(s)?:\/\//

        case link
        when /^http(s)?:\/\/(www\.)?youtube\.com\/watch\?v=([a-zA-Z0-9_-]*).*$/
                debug "when1"
                debug $1
                debug $2
        end

        info "PROCESSED:#{link}"
        return link
    end
end
