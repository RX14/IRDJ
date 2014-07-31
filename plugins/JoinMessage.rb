require 'cinch'

class JoinMessage
    include Cinch::Plugin

    listen_to :join, method: :join

    def join(m)
        $pconf["JOIN_MESSAGES"].each {|msg| m.reply msg }
    end

end
