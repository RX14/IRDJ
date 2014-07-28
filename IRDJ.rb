#!/usr/bin/env ruby
require 'cinch'

#FUCK YOU TWITCH! IMPLEMENT IRC PROPERLY!
class Cinch::Message
    def reply(string)
        string = string.to_s.gsub('<','&lt;').gsub('>','&gt;')
        bot.irc.send ":#{bot.config.user}!#{bot.config.user}@#{bot.config.user}.tmi.twitch.tv PRIVMSG #{channel} :#{string}"
    end
end

bot = Cinch::Bot.new do
    configure do |c|
        c.server   = ARGV[0]
        c.channels = [ARGV[1]]
        c.nick     = ARGV[2]
        c.password = ARGV[3]
    end

    on :join do |m|
        m.reply "/color GoldenRod"
    end

    on :message, "!IRDJ" do |m|
        m.reply "I am IRDJ, a SUPERIOR DJ bot using VLC made by RX14 for Lordmau5"
    end

    on :message, /^((!songs)|(!songrequest))$/ do |m|
        m.reply "Use !songrequest [Youtube/Soundcloud/mp3/etc. URL] to request a song."
    end

end

bot.start
