class NPC < ApplicationRecord
  def self.random
    npc = self.new
    npc.age = RandomTables::Age.random
    npc.attitude = RandomTables::Attitude.random
    npc.ancestry = RandomTables::Ethnicity.random # TODO: rename to an·ces·try
    npc.gender = RandomTables::Gender.random
    npc.origin = RandomTables::Origin.random
    npc
  end
end
