require 'open-uri'

module Embot
  module MessageHandler

    # Repost command handler
    #
    # This command handler will post a repost gif
    # 
    #
    # Triggers on command:  /repost
    
    class Clear < Base
      def process(message)
        return nil if !message.command_is?('/clear')
        quote = ('http://lol.jaykillah.net/images/clear.png')

        if quote.nil?
          return speak('Sorry, unable to fetch quote at the moment')
        end

        speak(quote)
      end

    end
  end
end
