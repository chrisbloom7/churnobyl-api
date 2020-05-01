class NPC < ApplicationRecord
  def self.random
    npc = self.new
    npc.first_name = RandomTables::FirstName.random
    npc.surname = RandomTables::Surname.random
    npc.age = RandomTables::AgeGroup.random
    npc.attitude = RandomTables::Attitude.random
    npc.ancestry = RandomTables::Ancestry.random
    npc.gender = RandomTables::GenderExpression.random
    npc.origin = RandomTables::Origin.random
    npc
  end
end
