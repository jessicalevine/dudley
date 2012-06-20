module Dudley
  class Config
    def self.[] key
      config[key]
    end

    def self.[]= key, value
      config[key] = value
    end

    # Loads a yaml file and merges it into the existing configuration. By
    # default, this method will use the value in Dudley::CONFIG_LOC but you can
    # load a different config file by passing in its path as an argument.
    def self.load_config config_path = nil
      # If a hash is passed in instead of a path, just merge it and return.
      if config_path.is_a? Hash
        config.deep_merge!(config_path)
        return
      end

      begin
        config_loc = config_path || Dudley::CONFIG_LOC
        yaml_file = YAML.load_file(config_loc)
      rescue Exception => e
        raise ConfigurationFileNotFound.new("No configuration file found at " +
                          "#{config_loc}. Have you made a configuration file?")
      end

      yaml_file.symbolize_keys!

      # Set some default behaviour
      #
      # Add a hash symbol to the start of a channel if the first character is
      # alphanumeric.
      if yaml_file[:server] and yaml_file[:server][:channel] and
         yaml_file[:server][:channel] =~ /^[a-zA-Z]/
        yaml_file[:server][:channel] = '#' + yaml_file[:server][:channel]
      end

      config.deep_merge!(yaml_file)
    end

    # Loads a YAML file filled with defaults for the dudley configuration. This
    # should be called before any other config files are loaded.
    def self.load_defaults
      yaml_file = YAML.load_file(Dudley::DEFAULTS_LOC)
      yaml_file.symbolize_keys!
      config.deep_merge!(yaml_file)
    end

    # Resets the configuration to an empty hash. Primarily for testing purposes.
    def self.reset_config
      config = Hash.new(nil)
    end

    private

    def self.config
      @@config ||= Hash.new(nil)
    end
  end
end
