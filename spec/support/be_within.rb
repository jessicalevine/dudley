RSpec::Matchers.define :be_within do |range|
  match do |actual|
    range.include? actual
  end
end
