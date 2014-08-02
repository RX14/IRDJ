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
        m.reply "I am IRDJ, a SUPERIOR set of cinchrb plugins made for Lordmau5"
    end
end
require_relative "conf"

@bot.start
