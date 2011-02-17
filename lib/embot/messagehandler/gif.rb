# this just grabs a random gif image from a personal site where i keep funny gifs

require 'nokogiri'
require 'open-uri'
require 'cgi'

module Embot
  module MessageHandler

    
    class Gif < Base
      def process(message)
        return nil if !message.command_is?('/gif')
        # return speak("Image of what?") if message.no_parameters?

        gif = get_random_image_url if message.command_is?('/gif')

        if gif.nil?
          return speak("Sorry, couldn't find any images for that search")
        end

        speak(gif)
      end

      private

      def get_random_image_url
        page  = Nokogiri::HTML(open("http://lol.jaykillah.net/"))
        links = page.css("#wrapper a").map { |link| link['href'] }
        
        return nil if links.nil? 
        
        gif  = links[rand(links.size)]

        "#{gif}"
        end

    end
  end
end
