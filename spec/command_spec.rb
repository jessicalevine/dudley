require 'spec_helper'

describe Dudley::Command do
  it "should correctly execute a roll given a roll command" do
    result = Dudley::Command.execute("!roll 1d6")
    result.should be_within 1..6 
  end

  it "should return nil given a nonexistant command" do
    result = Dudley::Command.execute("!foo")
    result.should be_nil
  end
end
