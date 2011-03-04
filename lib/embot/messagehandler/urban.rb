require 'nokogiri'
require 'open-uri'
require 'cgi'
module Embot module MessageHandler # Urban Dictionary message handler #
    # This message handler will perform an Urban Dictionary search with the parameters
    # given as the query and post it to Campfire.
    #
    # Triggers on command: embot define [search query]
    class Define < Base
      def process(message)
        return nil if !message.command_is?('/urban')
        return speak("Define what?") if message.no_parameters?

        definition = get_definition(message.parameters)

        if definition.nil?
          return speak("Sorry, no definitions for '#{message.parameters}'")
        end

        speak(definition)
      end

      private

      def get_definition(query)
       page       = Nokogiri::HTML(open("http://www.urbandictionary.com/define.php?term=#{CGI::escape(query)}"))

       definition = page.search('//div[@class = "definition"]').first.text
			 link = ("http://www.urbandictionary.com/define.php?term=#{CGI::escape(query)}")

       return nil if definition.nil?
			
			 format_defnition(definition, link)
       definition.inner_html.gsub('<br>', ' - ').gsub(%r{</?[^>]+?>}, '')

			end
			def format_definition(definition, link)
				"\"#{definition}\" - #{link}"
      end
    end
  end
end
