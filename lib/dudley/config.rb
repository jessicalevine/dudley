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
      begin
        yaml_file = YAML.load_file(config_path || Dudley::CONFIG_LOC)
      rescue Exception => e
        raise ConfigurationFileNotFound.new("No configuration file found at #{CONFIG_LOC}. Have you made a configuration file?")
      end

      yaml_file.symbolize_keys!
      config.merge!(yaml_file)
    end

    private

    def self.config
      @@config ||= Hash.new(nil)
    end
  end
end
