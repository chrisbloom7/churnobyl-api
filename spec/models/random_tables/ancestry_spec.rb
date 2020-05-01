require 'rails_helper'

RSpec.describe RandomTables::Ancestry, type: :model do
  it_behaves_like "random_table"

  describe ".mixed" do
    let(:default_max) { 2 }
    let(:max) { 3 }
    let(:min) { 1 }
    let(:default_separator) { "/" }
    let(:unique_ancestry1) { described_class.new(value: "unique_ancestry1") }
    let(:unique_ancestry2) { described_class.new(value: "unique_ancestry2") }
    let(:unique_ancestry3) { described_class.new(value: "unique_ancestry3") }
    let(:duplicate_ancestry) { unique_ancestry1 }

    it "selects random ancestries" do
      expect(described_class).to receive(:random).at_least(:once).and_call_original
      described_class.mixed
    end

    it "returns a string by default" do
      expect(described_class.mixed).to be_a(String)
    end

    it "can return an array of ancestry instances instead" do
      ancestries = described_class.mixed(join: false)
      expect(ancestries).to be_an(Array)
      expect(ancestries).to all(be_an_instance_of(described_class))
    end

    it "selects a maximum of `max` unique random ancestries to construct the string" do
      # Ensure the RNG receives and then selects the max
      expect(described_class).to receive(:rand).with(max).and_return(max - 1)

      # Ensure unique entries are returned
      expect(described_class).to receive(:random).exactly(max).times.and_return(unique_ancestry1, unique_ancestry2, unique_ancestry3)

      ancestries = described_class.mixed(max: max, join: false)
      expect(ancestries).to contain_exactly(unique_ancestry1, unique_ancestry2, unique_ancestry3)
    end

    it "selects a minimum of 1 ancestry to construct the string" do
      # Ensure the RNG receives the max but selects the min
      expect(described_class).to receive(:rand).with(max).and_return(min - 1)

      # Ensure unique entries are returned
      expect(described_class).to receive(:random).exactly(min).times.and_return(unique_ancestry1)

      ancestries = described_class.mixed(max: max, join: false)
      expect(ancestries).to contain_exactly(unique_ancestry1)
    end

    it "defaults to a `max` of 2 unique ancestries" do
      # Ensure the RNG receives and then selects the default max
      expect(described_class).to receive(:rand).with(default_max).and_return(default_max - 1)

      # Ensure unique entries are returned
      expect(described_class).to receive(:random).exactly(default_max).times.and_return(unique_ancestry1, unique_ancestry2)

      ancestries = described_class.mixed(join: false)
      expect(ancestries).to contain_exactly(unique_ancestry1, unique_ancestry2)
    end

    it "removes non unique ancestries" do
      # Ensure the RNG receives and then selects the default max
      expect(described_class).to receive(:rand).with(default_max).and_return(default_max - 1)

      # Ensure non-unique entries are returned
      expect(described_class).to receive(:random).exactly(default_max).times.and_return(unique_ancestry1, duplicate_ancestry)

      ancestries = described_class.mixed(join: false)
      expect(ancestries).to contain_exactly(unique_ancestry1)
    end

    it "joins ancestries with \"/\" by default" do
      # Ensure the RNG receives and then selects the default max
      expect(described_class).to receive(:rand).with(default_max).and_return(default_max - 1)

      # Ensure unique entries are returned
      expect(described_class).to receive(:random).exactly(default_max).times.and_return(unique_ancestry1, unique_ancestry2)

      ancestries = described_class.mixed
      expect(ancestries).to eq("#{unique_ancestry1.value}#{default_separator}#{unique_ancestry2.value}")
    end

    it "can accept a different separator to join ancestries on" do
      # Ensure the RNG receives and then selects the default max
      expect(described_class).to receive(:rand).with(default_max).and_return(default_max - 1)

      # Ensure unique entries are returned
      expect(described_class).to receive(:random).exactly(default_max).times.and_return(unique_ancestry1, unique_ancestry2)

      separator = ", "
      ancestries = described_class.mixed(separator: separator)
      expect(ancestries).to eq("#{unique_ancestry1.value}#{separator}#{unique_ancestry2.value}")
    end
  end
end
