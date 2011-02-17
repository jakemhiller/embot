require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'cgi'

module Embot
  module MessageHandler

    # Wikipedia command handler
    #
    # This command handler will perform a Wikipedia search with the parameters
    # given as the query post the first paragraph of the article, and a link.
    #
    # Triggers on command: embot wikipedia [search query]
    class Wiki < Base
      def process(message)
        return nil if !message.command_is?('/wiki')
        return speak("What do you want me to lookup on Wikipedia?") if message.no_parameters?

        definition = get_wikipedia(message.parameters)

        if definition.nil?
          return speak("Sorry, no definitions for '#{message.parameters}'")
        end

        speak(definition)
      end

      private

      def get_wikipedia(query)
             page = Nokogiri::HTML(open("http://www.google.com/search?hl=en&q=#{CGI::escape(query)}+site%3Aen.wikipedia.org&btnI=I%27m+Feeling+Lucky"))

             definition = page.css("#bodyContent > p").first.text
             link = page.css("#ca-nstab-main.selected a").map { |link| link['href'] }
             
             # return nil if definition.nil?
             # Embot::log(article)
             # link = ("http://en.wikipedia.org" << article['href'])
             
             format_definition(definition, link)
            end
      def format_definition(definition, link)
        "\"#{definition}\" - http://en.wikipedia.org#{link}"
      end
    end
  end
end