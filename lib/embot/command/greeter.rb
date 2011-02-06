module Embot
  module Command

    # Greeter command handler
    #
    # Simple command handler that will say "Welcome #{username}!" to users
    # who enter the chat room.
    #
    # In addition to greeting new users, it will also respond with "Hi #{username}" if users are greeting
    # the bot with a message that starts with: "hi|hey|hello|yo embot" (case insensitive).
    class Greeter < Base
      def process(message)
        if message.is_enter?
          return welcome_user(message)
        elsif message.is_text_message? and message.matches_regex?(/^(hi|hey|hello|yo) embot/i)
          return greet_user(message)
        else
          return nil
        end
      end

      private

      def welcome_user(message)
        speak("Welcome #{message.user_firstname}!")
      end

      def greet_user(message)
        speak("Hi #{message.user_firstname}")
      end
    end
  end
end
