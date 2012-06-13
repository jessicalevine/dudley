module Dudley
  class DiceParser
    def self.parse dice
      return nil if dice.nil? || !dice.is_a?(String) || dice == ""
      return nil if dice =~ /[^\+,d0-9\s]/ # err if string contains invalid characters

      rolls = dice.split ','
      sum = 0
      rolls.each do |roll|
        num_dice, dice_max, bonus = roll.split(/\+|d/).map(&:to_i)
        num_dice.times { sum += rand(dice_max) + 1 }
        sum += bonus if bonus
      end
      sum
    end
  end
end
