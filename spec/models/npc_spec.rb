require 'rails_helper'

RSpec.describe NPC, type: :model do
  describe ".random" do
    let(:npc) { NPC.random }

    it "generates a random NPC" do
      expect(npc).to be_a(NPC)
      expect(npc.age).to_not be_nil
      expect(npc.ancestry).to_not be_nil
      expect(npc.attitude).to_not be_nil
      expect(npc.first_name).to_not be_nil
      expect(npc.gender).to_not be_nil
      expect(npc.origin).to_not be_nil
      expect(npc.surname).to_not be_nil
    end
  end
end
