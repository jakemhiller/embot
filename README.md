# Embot: A Simple Campfire Bot #

Embot is a simple bot for [37signals'](http://37signals.com)
[Campfire](http://campfirenow.com/) chat application. Embot can connect
to a specific room and start listening for incomming messages. Each
message will be parsed on to a series of *message handlers* until one
of them reacts upon the message and writes something back to the chat
room.

- - -

## Built-in Message Handlers ##

Embot comes with a couple of message handlers to go:

### Bash.org Quote Fetcher ###

Whenever you want to have a random quote from
[Bash.org](http://bash.org), simply type `embot bash` or `embot bash
random` into the chat and Embot will then go fetch a quote and paste
it into the chat.

You can also get a quote with a specific topic, by issuing the following
command: `embot bash [your desired search term]` and Embot will retrieve
the first quote from that search.

### Google Define Search ###

Did someone just say a weird acronym or word you haven't heard before?
Embot can help you with a definition by issuing a Google `define:xxx`
query and send it back to the chat. To get a definition from Embot,
issue this command: `embot define [whatever you want to know
about]`.

### The Greeter ###

The Greeter will welcome users who enter the chat and greet back, when
somebody writes a message that begins with `hi|hey|hello|yo embot`

### Google Image Finder ###

Want to see a picture of *fail*? write `embot image fail`. Or what
about a picture of Pedobear? write `embot image pedobear`.

**Warning:** This message handler is very addictive and can decrease
employee productivity with up to 60%!

### Random Quote Fetcher ###

If you feel the need for some inspiration, type `embot quote` and get a
random quote from [quotationspage.com](http://quotationspage.com/).

- - -

## Setting Up And Running Embot ##

To use Embot in your Campfire account, you need to fill out some
information so Embot knows where to connect and with what user.
Open `embot.rb` and fill out the constants with correct information:

 * `CAMPFIRE_SUBDOMAIN`: The subdomain where your campfire account is
   located (*xxxx*.campfirenow.com)
 * `CAMPFIRE_TOKEN`: The API Authentication token of the user, you want
   Embot to connect as
 * `CAMPFIRE_USER_ID`: The numeric ID of the user Embot will connect as.
   This is used to filter out messages that come from Embot itself
 * `CAMPFIRE_ROOM`: The name of the chat room you want Embot to join

When everything has been typed in, simply open the terminal and go to the directory where
Embot is located and type `ruby embot.rb`.

### Gem Dependencies ###

Embot uses the [Tinder gem](https://github.com/collectiveidea/tinder) to
interact with Campfire. Install Tinder by typing `gem install tinder` in
the terminal.

Most message handlers in Embot makes use of the [Nokogiri gem](http://nokogiri.org)
to scrape content from websites. Install Nokogiri by typing `gem install nokogiri`
in the terminal.

- - -

## Creating Your Own Message Handlers ##

Creating your own message handlers for Embot is pretty straigh-forward,
if you know the [Ruby language](http://ruby-lang.org) of course. ;)

Here are the steps to create a message handler:

 * Create a new `.rb` file in the `lib/embot/messagehandler` folder
 * Create a new class in the `Embot::MessageHandler` module that inherits from
   `Embot::MessageHandler::Base` class (see example code further down)
 * Implement a method called `process` which takes one parameter called
   `message` (will be an instance of `Embot::Message` class)
 * Return a message with one of `speak`, `paste`, `play` or `tweet`
   methods if you want the message handler to react to the given
message.
 * If you don't want to react to the given message, simply return `nil`
 * `require` your new message handler at the top of the `embot.rb` file
   (`require './lib/embot/messagehandler/example.rb'`)
 * Register and instance of your message handler in the `@message_handlers` array in `lib/embot.rb`
   file

### Example Message Handler File ###

This example message handler will write "Hey, watch your mouth!" if it
sees a message that contain the word "fuck"

    module Embot
      module MessageHandler
        class Example < Base
          def process(message)
            return speak("Hey, watch your mouth!") if message.body.include? 'fuck'

            nil
          end
        end
      end
    end

- - -

## Disclaimer ##

This code was hacked together in a weekend where I needed something to
code in order to practice my Ruby coding skills. I haven't put much
thought into the code architecture and as I am still on the path to move
from PHP to Ruby, it might not be the most beautiful Ruby code you have
ever seen, but please don't hesitate to give me advice on improvements
or more *Ruby*-like ways if doing stuff! :)
