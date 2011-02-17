module Embot
  module MessageHandler

    # just shows what commands are available, this is very much a WIP

    class Help < Base
      def process(message)
        if message.is_enter?
        elsif message.is_text_message? and message.matches_regex?(/^embot help/i)
          return greet_user(message)
        else
          return nil
        end
      end

      private

      def greet_user(message)
        speak("image, define, quote, repost, wikipedia")
      end
    end
  end
end
