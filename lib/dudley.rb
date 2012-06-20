libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

# Require all of the Ruby files in the given directory.
#
# path - The String relative path from here to the directory.
#
# Returns nothing.
def require_all(path)
  glob = File.join(File.dirname(__FILE__), path, '*.rb')
  Dir[glob].each do |f|
    require f
  end
end

require 'IRC'
require 'pry'
require 'yaml'
require 'colored'
require 'logger'

require_all 'dudley'
require_all 'dudley/errors'
require_all 'dudley/patches'
require_all 'dudley/commands'

module Dudley
  VERSION      = "0.1"
  ROOTDIR      = File.expand_path(File.dirname(__FILE__) + '/..')
  SPECDIR      = ROOTDIR + '/spec'
  DATADIR      = SPECDIR + '/data'
  CONFIG_LOC   = ROOTDIR + '/.dudley.yml'
  DEFAULTS_LOC = ROOTDIR + '/.dudley.defaults.yml'
end

# Load the default configuration file
begin
  Dudley::Config.load_defaults
  Dudley::Config.load_config
rescue Dudley::ConfigurationFileNotFound => e
  Dudley.log.error e.message
  exit 1
end
