# Dudley

Dudley aims to be an IRC bot that makes running DnD campaigns via an IRC channel
easier. In its current form it is very basic, only really handling dice rolls,
but more functionality is being thought out for the future.

## Installation

Currently the best way to run Dudley is to clone this git repository and run the
executable in the `bin/` directory.

    $ git clone https://github.com/mrjordangoldstein/dudley.git
    $ cd dudley
    $ ./bin/dudley

## Configuration

You'll probably notice if you ran the commands in the above section that Dudley
complains because you have no configuration file set up. In order to configure
Dudley, you will need to copy the sample configuration file to the destination
that Dudley expects to find it in:

    $ cp .dudley.sample.yml .dudley.yml

Once that is done, open up the config file and enter the details of the IRC
server and channel appropriately.

### Configuration Defaults

If you are curious about what any of the configuration defaults are, all
defaults are stored in the `.dudley.defaults.yml` file.

## Usage

When Dudley has successfully connected to an IRC channel, it will sit and wait
for a command string. A command string is any string that starts with an
exclamation mark (!).

### !roll

The `!roll` command takes any standard DnD dice syntax and performs a roll. This
is best demonstrated by example:

    !roll 1d6

Will return any value between 1 and 6.

    !roll 1d6 + 4

Will return any value between 5 and 10.

    !roll 4d8

Will roll 4 8 sided die and return the value, which is between 4 and 32.

    !roll 4d8, 1d6 + 2, 2d4

Will perform multiple rolls, sum them and return the result. This can be
anything from... well, you get the picture :)

## Development

If you're interested in contributing to Dudley, feel free to fork the project
and send us a pull request.

We use the [git-flow](http://nvie.com/posts/a-successful-git-branching-model/)
branching model and will only accept pull requests if they are in a feature
branch. Please don't commit directly to develop or master.

### Writing a new Dudley command

It's incredibly simple to write a new Dudley command. All Dudley commands are
located in the `lib/dudley/commands/` directory. Let's take a look at the
existing `!roll` command as an example:

``` ruby
    module Dudley::Commands
      class Roll < Command
        command :roll do |input|
          DiceParser.parse input
        end

        namespace :roll do
          command :init do |input|
            # Stub for rolling init.
            "Implement me!"
          end
        end
      end
    end
```

Commands must subclass the `Dudley::Commands::Command` class. Doing so gives you
access to the `namespace` and `command` helper methods to form a mini-DSL for
creating Dudley commands.

When you use the `command` method, the first argument is the name of the
command, which can be anything that responds to `to_s` and then a block, the
return value of which will be output by Dudley in the IRC channel. In this case,
the `DiceParser.parse` method will output an integer back to the channel.

The `namespace` helper simply allows you to group your commands together
Rake-style. So the `:init` command in the `:roll` namespace is called by sending
the `!roll:init` command in the IRC channel that Dudley is in.

Any exceptions thrown inside a command that are not caught will be handled by
Dudley and the error message contained in the exception will be output back in
to the IRC channel as an error message.
