require 'rails_helper'

RSpec.describe NPC, type: :model do
  describe ".random" do
    let(:npc) { NPC.random }

    it "generates an unpersisted random NPC" do
      expect(npc).to be_a_new(NPC)
      expect(npc.age).to_not be_nil
      expect(npc.ancestry).to_not be_nil
      expect(npc.attitude).to_not be_nil
      expect(npc.first_name).to_not be_nil
      expect(npc.gender).to_not be_nil
      expect(npc.origin).to_not be_nil
      expect(npc.surname).to_not be_nil
    end
  end

  describe ".list" do
    let(:size) { 3 }
    let(:list) { NPC.list(size) }

    it "generates a list of unpersisted NPCs" do
      expect(list).to be_an(Array)
      expect(list.size).to eq(size)
      expect(list).to all(be_a_new(NPC))
    end
  end

  describe ".create_random" do
    let(:npc) { NPC.create_random }

    it "persists a random NPC to the database" do
      expect(npc).to be_a(NPC)
      expect(npc).to be_persisted
    end
  end

  describe ".create_list" do
    let(:size) { 3 }
    let(:list) { NPC.create_list(size) }

    it "persists a list of random NPCs to the database" do
      expect(list).to be_an(Array)
      expect(list.size).to eq(size)
      expect(list).to all(be_a(NPC))
      expect(list).to all(be_persisted)
    end
  end
end
