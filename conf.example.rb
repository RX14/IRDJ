$bot.configure do |conf|
    conf.server   = "irc.twitch.tv"
    conf.channels = ["#mytwitchchannel"]
    conf.nick     = "twitchbot1000"
    conf.password = "oauth:blablabla"
    
    #Plugin class names, generally the names of the files.
    conf.plugins.plugins = [IRDJ, JoinMessage]
end

#$pconf is a key-value store used by plugins for configuration.
#Here we set "JOIN_MESSAGES" to a string aray for the JoinMessage plugin.
$pconf["JOIN_MESSAGES"] = ["/color GoldenRod"]
