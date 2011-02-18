require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'cgi'

module Embot
  module MessageHandler

    # Wikipedia command handler
    #
    # This command handler will perform a Imdb search with the parameters
    #
    # Triggers on command: /imdb [search query]
    class Imdb < Base
      def process(message)
        return nil if !message.command_is?('/imdb')
        return speak("What do you want me to lookup on IMDB?") if message.no_parameters?

        definition = get_wikipedia(message.parameters)

        if definition.nil?
          return speak("Sorry, no definitions for '#{message.parameters}'")
        end

        speak(definition)
      end

      private

      def get_wikipedia(query)
             page = Nokogiri::HTML(open("http://www.google.com/search?hl=en&q=#{CGI::escape(query)}+site%3Aimdb.com&btnI=I%27m+Feeling+Lucky"))

             definition = page.css("#overview-top > p").first.text
             link = page.css("#content-1 div.article.links div:first-child.link_column a:first-child.link").map { |link| link['href'].gsub('/filmotype', '') }

             # return nil if definition.nil?
             # Embot::log(article)
             # link = ("http://en.wikipedia.org" << article['href'])
             
             format_definition(definition, link)
            end
      def format_definition(definition, link)
        "\"#{definition}\" - http://imdb.com#{link}"
      end
    end
  end
end