require 'spec_helper'

describe Dudley::Command do
  it "should correctly execute a roll given a roll command" do
    result = Dudley::Command.execute("!roll 1d6")
    result.should be_within 1..6
  end

  it "should throw an exception given a nonexistant command" do
    lambda do
      Dudley::Command.execute("!foo")
    end.should raise_error Dudley::CommandDoesNotExist
  end
end
