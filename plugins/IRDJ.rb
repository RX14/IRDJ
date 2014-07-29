require 'cinch'
require 'vlc-client'

class IRDJ
=begin
    include Cinch::Plugin

    match //

    def vlc_check
        @vlc.server.start unless @vlc.server.running?
    end

    #Start server and connect
    @vlc = VLC::System.new(auto_start: false)
    vlc_check

    on :join do |m|
        m.reply "/color GoldenRod"
    end

    on :message, "!IRDJ" do |m|
        m.reply "I am IRDJ, a SUPERIOR DJ bot using VLC made by RX14 for Lordmau5"
    end

    on :message, /^((!songs)|(!songrequest))$/ do |m|
        m.reply "Use !songrequest [Youtube/Soundcloud/mp3/etc. URL] to request a song."
    end

    on :message, /^!songrequest .*/ do |m|
        vlc_check
        @vlc.play "https://www.youtube.com/watch?v=kV3TZf-gbs8"
    end
=end
end
