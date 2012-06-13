module Dudley
  class Command
   def self.execute cmd
     task, input = cmd.slice(1, cmd.size).split(' ', 2)
     case task
     when "roll"
       return DiceParser.parse input
     else
       return nil
     end
   end
  end
end
