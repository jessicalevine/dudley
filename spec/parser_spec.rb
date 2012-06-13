require 'spec_helper'

describe Dudley::DiceParser do
  it "should correctly parse simple dice rolls" do
    100.times do
      result = Dudley::DiceParser.parse("1d6")
      result.should be_within 1..6
    end
  end

  it "should correctly parse simple dice rolls with modifier" do
    100.times do
      result = Dudley::DiceParser.parse("1d6 + 5")
      result.should be_within 6..11
    end
  end

  it "should correctly parse multiple simple dice rolls with modifier" do
    100.times do
      result = Dudley::DiceParser.parse("1d6+5,1d4, 1d8+2")
      result.should be_within 10..25
    end
  end

  it "should return nil when given nil input" do
    result = Dudley::DiceParser.parse(nil)
    result.should be_nil
  end

  it "should return nil when given an empty string as input" do
    result = Dudley::DiceParser.parse("")
    result.should be_nil
  end

  it "should return nil when given a non-string as input" do
    result = Dudley::DiceParser.parse(2)
    result.should be_nil
  end

  it "should return nil when given an invalid character in input" do
    result = Dudley::DiceParser.parse("1d4c+4")
    result.should be_nil
  end

  it "should return nil when given invalidly formatted input" do
    result = Dudley::DiceParser.parse("1+4d3")
    result.should be_nil
    result = Dudley::DiceParser.parse("1d4,+3")
    result.should be_nil
  end
end
