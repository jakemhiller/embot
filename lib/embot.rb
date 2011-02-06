module Embot

  # Active command handlers that will process
  # messages from the chat
  #
  # To disable a command, simply comment it out
  @commands = [
    Embot::Command::Bash.new,
    Embot::Command::Define.new,
    Embot::Command::Image.new,
    Embot::Command::Quote.new,
    Embot::Command::Greeter.new,
  ]

  # Process a chat message
  #
  # The method will send the message to each
  # command handler in @commands variable until
  # a command handler acts on the message. 
  #
  # If no command handlers get triggered by the
  # message, it will return nil
  def self.process_message(message)
    @commands.each do |command|
      response = command.process(message)
      return response unless response.nil?
    end

    nil
  end

  # Put a message out to the terminal
  #
  # type can be any arbitrary :symbol
  def self.log(message, type=:info)
    puts "  [#{type.to_s}] #{message}"
  end

  # Make an excerpt of a string, if it exceeds the maximum length
  def self.excerpt(text, maximum_length = 30, append = '...')
    text = text.to_s
    if text.length > maximum_length
      text = text[0...maximum_length] + append
    end

    return text.gsub("\n", ' ')
  end
end
