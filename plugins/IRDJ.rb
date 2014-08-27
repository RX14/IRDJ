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
        url, success = process(link)
        case success
            when true
                nil, position = @vlc_q.push url
                m.reply "Hey #{m.user}, your request is coming up in #{position} songs"

            when false
                m.reply "Dammit #{m.user}, y u no give me correct link *kills a kitten*"
        end



        @vlc_q.each_with_index {|item, i| debug "QUEUE #{i}: #{item.to_s}"}
    end

    def process(link)
        return link, false unless valid? link

        case link
            when /(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/
                code = $1
                link = "https://www.youtube.com/watch?v=#{code}"
                success = true
            else
                success = false
        end

        debug "parse #{success ? "success" : "failure"}: #{link}"

        return link, success
    end

    def valid?(link)
        uri = URI.parse link
        return uri.kind_of? URI::HTTP
    end

end
