class NPC < ApplicationRecord
  def self.random
    npc = self.new
    npc.age = Age.random
    npc.attitude = Attitude.random
    npc.ethnicity = Ethnicity.random # TODO: rename to ethnic_herritage
    npc.gender = Gender.random
    npc.origin = Origin.random
    npc
  end
end
