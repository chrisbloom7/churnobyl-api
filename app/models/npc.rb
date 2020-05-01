class NPC < ApplicationRecord
  def self.random
    npc = self.new
    npc.first_name = RandomTables::FirstName.random.value
    npc.surname = RandomTables::Surname.hyphenated
    npc.age = RandomTables::AgeGroup.random.value
    npc.attitude = RandomTables::Attitude.random.value
    npc.ancestry = RandomTables::Ancestry.mixed
    npc.gender = RandomTables::GenderExpression.random.value
    npc.origin = RandomTables::Origin.random.value
    npc
  end
end
