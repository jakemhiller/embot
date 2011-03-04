module Embot

  # Active message handlers that will process
  # messages from the chat
  #
  # To disable a handler, simply comment it out
  @message_handlers = [
    # Embot::MessageHandler::Bash.new,
    Embot::MessageHandler::Define.new,
    Embot::MessageHandler::Urban.new,
    Embot::MessageHandler::Image.new,
    Embot::MessageHandler::Quote.new,
    Embot::MessageHandler::Greeter.new,
    Embot::MessageHandler::Repost.new,
    Embot::MessageHandler::Wiki.new,
    Embot::MessageHandler::Help.new,
    Embot::MessageHandler::Gif.new,
    Embot::MessageHandler::Clear.new,
    Embot::MessageHandler::Imdb.new,
  ]

  # Process a chat message
  #
  # The method will send the message to each
  # message handler in @message_handlers variable until
  # a message handler acts on the message.
  #
  # If no message handlers get triggered by the
  # message, it will return nil
  def self.process_message(message)
    @message_handlers.each do |handler|
      response = handler.process(message)
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
