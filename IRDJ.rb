#!/usr/bin/env ruby
require 'cinch'

#Patch reply method to work with twitch: FUCK YOU TWITCH! IMPLEMENT IRC PROPERLY!
class Cinch::Message
    def reply(string)
        string = string.to_s.gsub('<','&lt;').gsub('>','&gt;')
        bot.irc.send ":#{bot.config.user}!#{bot.config.user}@#{bot.config.user}.tmi.twitch.tv PRIVMSG #{channel} :#{string}"
    end
end

#global plugin config hash
$pconf = {}

#Load plugin files
Dir[File.dirname(__FILE__) + '/plugins/*.rb'].each {|file| require file }

@bot = Cinch::Bot.new do
    on :message, "!IRDJ" do |m|
        m.reply "I am IRDJ, a set of open source bot plugins made for Lordmau5. http://www.github.com/RX14/IRDJ"
    end
end
require_relative "conf"

@bot.start
