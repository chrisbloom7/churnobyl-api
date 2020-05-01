require 'rails_helper'

RSpec.describe NPCSerializer, type: :serializer do
  let(:npc) { NPC.random }
  let(:subject) { NPCSerializer.new(npc) }
  let(:json) { subject.to_json }
  let(:serialized_npc) { JSON.parse(json) }

  describe "serialization" do
    it "serializes an NPC" do
      data = serialized_npc["data"]
      attributes = data["attributes"]
      expect(data["type"]).to eq("npc")
      expect(attributes["age"]).to eq(npc.age)
      expect(attributes["age"]).to eq(npc.age)
      expect(attributes["ancestry"]).to eq(npc.ancestry)
      expect(attributes["attitude"]).to eq(npc.attitude)
      expect(attributes["first_name"]).to eq(npc.first_name)
      expect(attributes["gender"]).to eq(npc.gender)
      expect(attributes["origin"]).to eq(npc.origin)
      expect(attributes["surname"]).to eq(npc.surname)
    end
  end
end
