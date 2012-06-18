module Dudley
  class Command
    def self.execute cmd
      command_name, input = cmd.slice(1, cmd.size).split(' ', 2)

      if commands[command_name]
        return commands[command_name].call input
      else
        raise CommandDoesNotExist.new("No command with name #{command_name} found.")
      end
    end

    def self.namespace new_namespace, &block
      current_namespace.unshift new_namespace
      block.call
      current_namespace.shift
    end

    def self.command name, &block
      # Get the fully namespaced name
      namespace  = current_namespace.map(&:to_s).join(':')

      # Add a trailing colon if a namespace exists. Without this check, all
      # commands would have a leading colon.
      namespace += ':' if namespace.length > 0

      # Concatenate the namespace and command name. Same syntax as namespaced
      # Rake tasks.
      name = namespace + name.to_s

      if commands.include?(name)
        raise CommandAlreadyExists.new("A command with name #{name} already exists")
      else
        commands[name] = block
      end
    end

    private

    # A hash containing all of the commands.
    def self.commands
      @@commands ||= Hash.new(nil)
    end

    # An array containing the current namespace.
    #
    # Example:
    #
    #   [:test, :roll]
    #   #=> With a command called "foo", this translates to:
    #   "test:roll:foo"
    def self.current_namespace
      @@current_namespace ||= []
    end
  end
end
