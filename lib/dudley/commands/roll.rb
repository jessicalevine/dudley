module Dudley
  class Roll < Command
    command :roll do |input|
      DiceParser.parse input
    end

    namespace :roll do
      command :init do |input|
        # Stub for rolling init.
        "Implement me!"
      end
    end
  end
end
