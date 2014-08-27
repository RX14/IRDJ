require 'cinch'
require 'uri'
require_relative '../lib/SimpleQueue.rb'
require 'vlc-client'

class IRDJ
    include Cinch::Plugin
    @prefix = //
    @suffix = //

    match /^((!songs)|(!songrequest))$/, method: :song_help
    match /^!songrequest (.+)$/, method: :song_req

    def initialize(*args)
        super
        @vlc_q = SimpleQueue.new

        Thread.new do
            #Start server and connect
            vlc = VLC::System.new
            vlc.connected?
            loop do
                song = @vlc_q.pop
                info "POPED:#{song}"
                vlc.play song
                sleep 1 until vlc.stopped?
            end
        end

    end

    def song_help(m)
        m.reply "Use !songrequest [Youtube/Soundcloud/mp3/etc. URL] to request a song."
    end

    def song_req(m, link)

        song, success = process(link)
        @vlc_q.push song if success

        @vlc_q.each_index {|int| debug "QUEUE #{int}: #{@vlc_q[int]}"}
    end

    def process(link)
        return link, false unless valid? link

        case link
            when /^https?:\/\/(?:[0-9A-Z-]+\.)?(?:youtu\.be\/|youtube(?:-nocookie)?\.com\S*[^\w\s-])([\w-]{11})(?=[^\w-]|$)(?![?=&+%\w.-]*(?:['"][^<>]*>|<\/a>))[?=&+%\w.-]*$/
                code = $1
                link = "https://www.youtube.com/watch?v=#{code}"
                success = true
            else
                success = false
        end

        return link, success
    end

    def valid?(link)
        uri = URI.parse link
        return uri.kind_of? URI::HTTP
    end

end
