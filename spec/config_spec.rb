describe Dudley::Config do
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
end
