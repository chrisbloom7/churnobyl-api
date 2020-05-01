class NPC < ApplicationRecord
  class << self
    def random
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

    def list(size)
      npcs = []
      size.times do
        npcs << self.random
      end
      npcs
    end

    def create_random
      npc = self.random
      npc.save
      npc
    end

    def create_list(size)
      list = self.list(size)
      list.each(&:save)
      list
    end
  end
end
