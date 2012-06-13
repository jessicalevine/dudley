module Dudley
  class DiceParser
    def self.parse dice
      return nil if dice.nil? || !dice.is_a?(String) || dice == ""
      return nil if dice =~ /[^\+,d0-9\s]/ # err if string contains invalid characters

      dice.gsub!(/\s/, '') # strip space
      rolls = dice.split ','
      sum = 0
      rolls.each do |roll|
        m = roll.match(/^(?<num_dice>\d+)d(?<dice_max>\d+)(?:\+(?<bonus>\d+))?$/)
        return nil unless m

        num_dice = m[:num_dice].to_i
        dice_max = m[:dice_max].to_i
        bonus = m[:bonus].to_i

        num_dice.times { sum += rand(dice_max) + 1 }
        sum += bonus if bonus
      end

      sum
    end
  end
end
