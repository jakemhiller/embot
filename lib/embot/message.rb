module Embot

  # Simple read-only class to encapsulate a Campfire chat message
  class Message
    attr_reader :trigger, :command, :parameters

    def initialize(message)
      @message = message
      @command, @parameters = message[:body].to_s.split(' ', 2)
    end

    def self.should_be_ignored?(message)
      return true if message.nil?
      return true if message[:type] == 'AdvertisementMessage'
      return true if message[:type] == 'TimestampMessage'
      return true if message[:user].nil?
      return true if message[:user][:id] == CAMPFIRE_USER_ID

      return false
    end

    # Get message body
    def body
      @message[:body]
    end

    # Get message type
    def type
      @message[:type]
    end

    # Get creation timestamp
    def created_at
      @message[:created_at]
    end

    # Get numeric ID of authoring user
    def user_id
      @message[:user][:id]
    end

    # Get full name of authoring user
    def user_name
      @message[:user][:name]
    end

    # Get firstname of authoring user
    def user_firstname
      return @message[:user][:name].split(' ').first
    end

    # Get parameters as an array of words
    def parameters_as_array
      @parameters.to_s.split(' ')
    end

    # Determine if message body starts with a certain string
    def start_with?(string)
      @message[:body].to_s.start_with?(string)
    end

    # Determine if message body matches certain regular expression
    def matches_regex?(regex)
      @message[:body].to_s.match(regex)
    end

    # Determine if command is a certain string
    def command_is?(command)
      @command.to_s == command
    end

    # Determie if parameters are a certain string
    def parameters_are?(parameters)
      @parameters.to_s == parameters
    end

    # Determine if message contains parameters or not
    def no_parameters?
      @parameters.nil? or @parameters.empty?
    end

    # Determine if message is a text message
    def is_text_message?
      type == 'TextMessage'
    end

    # Determine if message is a paste message
    def is_paste?
      type == 'PasteMessage'
    end

    # Determine if message is a sound message (i.e. /play trombone)
    def is_sound?
      type == 'SoundMessage'
    end

    # Determine if message is a tweet message
    def is_tweet?
      type == 'TweetMessage'
    end

    # Determine if message is an "enter" message (xxx has entered the room)
    def is_enter?
      type == 'EnterMessage'
    end

    # Determine if message is a "leave" message (xxx left the room)
    def is_leave?
      type == 'LeaveMessage'
    end
  end
end
