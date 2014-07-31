require 'cinch'
require 'thread'
require 'vlc-client'

class IRDJ
    include Cinch::Plugin
    @prefix = //
    @suffix = //

    match /^((!songs)|(!songrequest))$/, method: :song_help
    match /^!songrequest (.+)$/, method: :execute

    $vlc_q = Queue.new

    vlcworker = Thread.new do
        #Start server and connect
        vlc = VLC::System.new
        vlc.connected?
        loop do
            song = $vlc_q.pop
            Cinch::Logger. "q:#{song}"
            vlc.play song
            puts "waiting till stopped"
            sleep 1 until vlc.stopped?
        end
    end

    def song_help(m)
        m.reply "Use !songrequest [Youtube/Soundcloud/mp3/etc. URL] to request a song."
    end

    def execute(m, link)
        puts "e:#{link}"
        $vlc_q << link
    end
end
