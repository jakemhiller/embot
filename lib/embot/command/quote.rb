require 'nokogiri'
require 'open-uri'

module Embot
  module Command

    # Quote command handler
    #
    # This command handler will post a random quote from
    # www.quotationspage.com
    #
    # Triggers on command: embot quote
    class Quote < Base
      def process(message)
        return nil if !message.is_for_embot? || !message.command_is?('quote')
        quote = random_quote

        if quote.nil?
          return speak('Sorry, unable to fetch quote at the moment')
        end

        speak(quote)
      end

      private

      def random_quote
        page   = Nokogiri::HTML(open('http://www.quotationspage.com/random.php3'))
        quote  = page.css("dt.quote").first
        author = page.css("dd.author b a").first

        return nil if quote.nil?

        format_quote(quote.content.strip, author.content.strip)
      end

      def format_quote(quote, author)
        "\"#{quote}\" - #{author}"
      end
    end
  end
end
