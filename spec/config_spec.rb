describe Dudley::Config do
  before :each do
    Dudley::Config.reset_config
  end

  it "should allow you to set config values" do
    Dudley::Config[:test_value] = 25
    Dudley::Config[:test_value].should == 25
  end

  it "should be able to read in config files" do
    Dudley::Config.load_config(Dudley::DATADIR + '/sample_config.yml')
    Dudley::Config[:server].should be_a Hash
    Dudley::Config[:server][:host].should == "192.168.1.131"
  end

  it "should throw an exception when missing config file" do
    lambda do
      Dudley::Config.load_config(Dudley::DATADIR + '/no/such/config.yml')
    end.should raise_error Dudley::ConfigurationFileNotFound
  end

  it "should default channels to a hash symbol" do
    Dudley::Config.load_config(Dudley::DATADIR + '/sample_config.yml')

    Dudley::Config[:server][:channel].should start_with('#')
  end

  it "should not add a hash to special channel types" do
    Dudley::Config.load_config(Dudley::DATADIR +
                               '/sample_config_special_channel.yml')

    Dudley::Config[:server][:channel].should_not start_with('#')
  end

  it "should correctly merge new configs on top of old ones" do
    # There was a bug when merging configs on top of each other when there were
    # nested hashes. The nested hashes would replace each other instead of
    # merging. It was fixed and this is the test to make sure it stays fixed.
    Dudley::Config.load_config({ :testing => { :value_1 => 12 } })
    Dudley::Config.load_config({ :testing => { :value_2 => 10 } })

    Dudley::Config[:testing][:value_1].should == 12
    Dudley::Config[:testing][:value_2].should == 10
  end
end
