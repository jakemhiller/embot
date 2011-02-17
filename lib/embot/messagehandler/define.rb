require 'nokogiri'
require 'open-uri'
require 'cgi'

module Embot
  module MessageHandler

    # Google Define message handler
    #
    # This message handler will perform a Google Define search with the parameters
    # given as the query and post it to Campfire.
    #
    # Triggers on command: embot define [search query]
    class Define < Base
      def process(message)
        return nil if !message.command_is?('/define')
        return speak("Define what?") if message.no_parameters?

        definition = get_definition(message.parameters)

        if definition.nil?
          return speak("Sorry, no definitions for '#{message.parameters}'")
        end

        speak(definition)
      end

      private

      def get_definition(query)
       page       = Nokogiri::HTML(open("http://www.google.com/search?hl=en&q=define:#{CGI::escape(query)}"))
       definition = page.css("ul.std li").first

       return nil if definition.nil?

       definition.inner_html.gsub('<br>', ' - ').gsub(%r{</?[^>]+?>}, '')
      end
    end
  end
end
