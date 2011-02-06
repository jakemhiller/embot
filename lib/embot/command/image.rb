require 'nokogiri'
require 'open-uri'
require 'cgi'

module Embot
  module Command

    # Image command handler
    #
    # This command handler will post a random image from Google Image Search
    # with the command parameters as search query
    #
    # Triggers on command: embot image [search query]
    class Image < Base
      def process(message)
        return nil if !message.is_for_embot? or !message.command_is?('image')
        return speak("Image of what?") if message.no_parameters?

        image_url = get_random_image_url(message.parameters)

        if image_url.nil?
          return speak("Sorry, couldn't find any images for '#{payload}'")
        end

        speak(image_url)
      end

      private

      def get_random_image_url(query)
        page  = Nokogiri::HTML(open("http://www.google.com/images?hl=en&q=#{CGI::escape(query)}"))
        links = page.css("#ImgCont table td a")
        link  = links[rand(links.size)]

        return nil if link.nil?

        extract_image_url(link['href'])
      end

      def extract_image_url(link)
        link.split('&').first.gsub('/imgres?imgurl=', '')
      end
    end
  end
end
