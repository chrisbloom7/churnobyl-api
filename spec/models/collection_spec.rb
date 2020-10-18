require 'rails_helper'

RSpec.describe Collection, type: :model do
  class RandomTables::Random
    def self.random
      "random"
    end
  end

  class RandomTables::RandomTwo
    def self.random
      "random 2"
    end
  end

  let(:valid_attributes) { { name: "name", default_label: "default" } }

  describe ".new" do
    it "requires a name" do
      expect(Collection.new(valid_attributes)).to be_valid
      instance = Collection.new(valid_attributes.except(:name))
      expect(instance).not_to be_valid
      expect(instance.errors.keys).to include(:name)
    end

    it "requires name to be unique" do
      Collection.create!(valid_attributes)
      instance = Collection.new(valid_attributes)
      expect(instance).not_to be_valid
      expect(instance.errors.keys).to include(:name)
    end

    it "requires a default_label" do
      expect(Collection.new(valid_attributes)).to be_valid
      instance = Collection.new(valid_attributes.except(:default_label))
      expect(instance).not_to be_valid
      expect(instance.errors.keys).to include(:default_label)
    end
  end

  describe "#execute" do
    subject { Collection.create!(valid_attributes) }

    it "calls execute on each attached template" do
      subject.templates << Template.new(label: "First", generator: "Random")
      subject.templates << Template.new(label: "Second", generator: "RandomTwo")
      results = subject.execute
      expect(results).to be_an(Array)
      expect(results.size).to eq(2)
      expect(results[0]).to include(label: "First", data: "random")
      expect(results[1]).to include(label: "Second", data: "random 2")
    end
  end
end
