require 'cinch'
require 'vlc-client'

class Spam
    include Cinch::Plugin
    @prefix = //
    @suffix = //

    match /^!spam start (.*)$/, method: :spam
    match /^!spam stop$/, method: :stop

    def spam(m, spam)
        @start = true
        while @start do
            m.reply spam
            sleep 2.5
        end
    end

    def stop(m)
        @start = false
    end
end
