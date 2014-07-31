@bot.configure do |conf|
    conf.server   = "irc.twitch.tv"
    conf.channels = ["#mytwitchchannel"]
    conf.nick     = "twitchbot1000"
    conf.password = "oauth:blablabla"
    conf.plugins.plugins = [IRDJ, JoinMessage]
end

$pconf["JOIN_MESSAGES"] = ["/color GoldenRod"]
