require 'cinch'
require 'vlc-client'

class Sandstorm
    include Cinch::Plugin
    @prefix = //
    @suffix = //

    match /^!sandstorm (.+)$/, method: :sandstorm

    def sandstorm(m, arg)
        case arg
            when "start"
                @start = true
                while @start do
                    m.reply "DUDUDUDUDUDUDUDUDUDUDUDUDUDUDUDUDUDUDUDUDUDUDUDUDUDUDU"
                    sleep 2.5
                end
            when "stop"
                @start = false
        end
    end
end
