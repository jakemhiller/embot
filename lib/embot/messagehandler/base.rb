module Embot
  module MessageHandler

    # Base message handler class
    # All message handlers should inherit from this class
    class Base

      protected

      # Create normal message
      def speak(message)
        { :type => :speak, :body => message }
      end

      # Create a paste message
      def paste(message)
        { :type => :paste, :body => message }
      end

      # Create a sound message
      def play(sound)
        { :type => :play, :body => sound }
      end

      # Create a tweet message
      def tweet(url)
        { :type => :tweet, :body => url }
      end
    end
  end
end
