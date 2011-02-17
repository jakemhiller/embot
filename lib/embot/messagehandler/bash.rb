require 'nokogiri'
require 'open-uri'
require 'cgi'

module Embot
  module MessageHandler

    # Bash quote message handler
    #
    # This handler will scrape bash.org for an IRC quote and
    # return it as a paste message to Campfire
    #
    # The message handler can fetch a random quote or a quote on a specific
    # topic, depending on the parameter. If 'random' is given as parameter, a
    # random quote will be returned, otherwise it will take the parameter and
    # search for a quote that matches.
    #
    # Triggers on command: embot bash [random|search query]
    class Bash < Base
      def process(message)
        return nil if !message.command_is?('/bash')

        if message.parameters_are?('random') or message.no_parameters?
          quote = random_quote
        else
          quote = by_search(message.parameters)
        end

        if !quote
          return speak("Sorry, couldn't find any quotes...")
        end

        paste(quote)
      end

      private

      def random_quote
        page  = Nokogiri::HTML(open('http://www.bash.org/?random'))
        quote = page.css("p.qt").first

        sanitize_quote(quote) unless quote.nil?
      end

      def by_search(query)
        page  = Nokogiri::HTML(open("http://www.bash.org/?search=#{CGI::escape(query)}&sort=0&show=25"))
        quote = page.css("p.qt").first

        sanitize_quote(quote) unless quote.nil?
      end

      def sanitize_quote(quote)
        quote.content.strip
      end
    end
  end
end
