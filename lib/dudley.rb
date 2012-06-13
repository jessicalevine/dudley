libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'IRC'
require 'yaml'
require 'dudley/config'
require 'dudley/patches/hash'

module Dudley
  ROOTDIR    = File.expand_path(File.dirname(__FILE__) + '/..')
  SPECDIR    = ROOTDIR + '/spec'
  DATADIR    = SPECDIR + '/data'
  CONFIG_LOC = ROOTDIR + '/.dudley.yml'
end

# Load the default configuration file
Dudley::Config.load_config
