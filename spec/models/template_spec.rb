require 'rails_helper'

RSpec.describe Template, type: :model do
  class RandomTables::Random
    def self.random
      "random"
    end
  end

  class RandomTables::NonRandom; end

  let(:collection) { Collection.new }
  let(:valid_attributes) { { collection: collection, label: "Test", generator: "Random" } }

  describe ".new" do
    it "requires an associated collection" do
      expect(Template.new(valid_attributes)).to be_valid
      instance = Template.new(valid_attributes.except(:collection))
      expect(instance).not_to be_valid
      expect(instance.errors.keys).to include(:collection)
    end

    it "requires a label" do
      expect(Template.new(valid_attributes)).to be_valid
      instance = Template.new(valid_attributes.except(:label))
      expect(instance).not_to be_valid
      expect(instance.errors.keys).to include(:label)
    end

    it "requires a generator" do
      expect(Template.new(valid_attributes)).to be_valid
      instance = Template.new(valid_attributes.except(:generator))
      expect(instance).not_to be_valid
      expect(instance.errors.keys).to include(:generator)
    end

    it "requires generator be a valid constant name" do
      instance = Template.new(valid_attributes.merge(generator: "random"))
      expect(instance).not_to be_valid
      expect(instance.errors.keys).to include(:generator)
    end

    it "requires generator represents a real class in RandomTables" do
      expect(Template.new(valid_attributes)).to be_valid
      instance = Template.new(valid_attributes.merge(generator: "ZzzZzzZzz"))
      expect(instance).not_to be_valid
      expect(instance.errors.keys).to include(:generator)
    end

    it "requires generator class responds to `.random`" do
      expect(Template.new(valid_attributes)).to be_valid
      instance = Template.new(valid_attributes.merge(generator: "NonRandom"))
      expect(instance).not_to be_valid
      expect(instance.errors.keys).to include(:generator)
    end
  end

  describe "#execute" do
    subject { Template.new(valid_attributes).execute }

    it "calls `.random` on the generator class" do
      expect(RandomTables::Random).to receive(:random)
      subject
    end

    it "returns a hash of the label and the generator data" do
      expect(subject).to be_a(Hash)
      expect(subject[:label]).to eq(valid_attributes[:label])
      expect(subject[:data]).to eq(RandomTables::Random.random)
    end

    it "returns no data if the generator class no longer represents a real class in RandomTables" do
      instance = Template.new(valid_attributes.merge(generator: "ZzzZzzZzz"))
      subject = instance.execute
      expect(subject).to be_a(Hash)
      expect(subject[:label]).to eq(valid_attributes[:label])
      expect(subject[:data]).to eq("")
    end

    it "returns no data if the generator class no longer responds to `.random`" do
      instance = Template.new(valid_attributes.merge(generator: "NonRandom"))
      subject = instance.execute
      expect(subject).to be_a(Hash)
      expect(subject[:label]).to eq(valid_attributes[:label])
      expect(subject[:data]).to eq("")
    end
  end
end
