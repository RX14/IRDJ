#!/usr/bin/env ruby
require 'cinch'

#FUCK YOU TWITCH! IMPLEMENT IRC PROPERLY!
class Cinch::Message
    def reply(string)
        string = string.to_s.gsub('<','&lt;').gsub('>','&gt;')
        bot.irc.send ":#{bot.config.user}!#{bot.config.user}@#{bot.config.user}.tmi.twitch.tv PRIVMSG #{channel} :#{string}"
    end
end

#Load plugin files
Dir[File.dirname(__FILE__) + '/plugins/*.rb'].each {|file| require file }

bot = Cinch::Bot.new do
    configure do |conf|
        require File.dirname(__FILE__) + '/IRDJ.conf'
    end
end

bot.start
