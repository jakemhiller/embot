require 'nokogiri'
require 'open-uri'
require 'cgi'

module Embot
  module MessageHandler

    # Image message handler
    #
    # This message handler will post a random image from Google Image Search
    # with the command parameters as search query
    #
    # Triggers on command: embot image [search query]
    class Image < Base
      def process(message)
        return nil if !message.command_is?('/image')
        return speak("Image of what?") if message.no_parameters?

        image_url = get_random_image_url(message.parameters)

        if image_url.nil?
          return speak("Sorry, couldn't find any images for that search")
        end

        speak(image_url)
      end

      private

      def get_random_image_url(query)
        page  = Nokogiri::HTML(open("http://www.google.com/images?as_q=#{CGI::escape(query)}&um=1&hl=en&sout=1&biw=1536&bih=983&gbv=1&btnG=Google+Search&as_epq=&as_oq=&as_eq=&as_sitesearch=&as_st=y&tbs=isch:1,isz:lt,islt:qsvga", 'User-Agent' => 'ruby'))

        links = page.css("#ImgCont td a").map { |link| link['href'].split('&').first.gsub('/imgres?imgurl=', '').gsub(/[^.jpg|^.jpeg|^.gif|^.png|^.JPG|^.JPEG|^.GIF|^.PNG]+$/, '') }

        link  = links[rand(links.size)]

        if link.nil?
          return nil
        end 

        link
      end
    end
  end
end

