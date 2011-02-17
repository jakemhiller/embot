require 'nokogiri'
require 'open-uri'

module Embot
  module MessageHandler

    # Repost command handler
    #
    # This command handler will post a repost gif
    # 
    #
    # Triggers on command:  /repost
    
    class Repost < Base
      def process(message)
        return nil if !message.command_is?('/repost')
        quote = ('http://jakehiller.com/images/REPOSTD.gif')

        if quote.nil?
          return speak('Sorry, unable to fetch quote at the moment')
        end

        speak(quote)
      end

    end
  end
end
