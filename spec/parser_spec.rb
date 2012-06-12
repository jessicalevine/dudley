require 'spec_helper'

describe "Dudley::DiceParser" do
  it "should correctly parse simply dice rolls" do
    result = Dudley::DiceParser.parse("1d6")
    result.should be >= 1
    result.should be <= 6
  end

  it "should correctly parse simply dice rolls with modifier" do
    result = Dudley::DiceParser.parse("1d6 + 1")
    result.should be >= 2
    result.should be <= 7
  end
end
