require 'rails_helper'

RSpec.describe RandomTables::Surname, type: :model do
  it_behaves_like "random_table"

  describe ".hyphenated" do
    let(:default_max) { 2 }
    let(:max) { 3 }
    let(:min) { 1 }
    let(:default_separator) { "-" }
    let(:unique_surname1) { described_class.new(value: "unique_surname1") }
    let(:unique_surname2) { described_class.new(value: "unique_surname2") }
    let(:unique_surname3) { described_class.new(value: "unique_surname3") }
    let(:duplicate_surname) { unique_surname1 }

    it "selects random surnames" do
      expect(described_class).to receive(:random).at_least(:once).and_call_original
      described_class.hyphenated
    end

    it "returns a string by default" do
      expect(described_class.hyphenated).to be_a(String)
    end

    it "can return an array of surname instances instead" do
      surnames = described_class.hyphenated(join: false)
      expect(surnames).to be_an(Array)
      expect(surnames).to all(be_an_instance_of(described_class))
    end

    it "selects a maximum of `max` unique random surnames to construct the string" do
      # Ensure the RNG receives and then selects the max
      expect(described_class).to receive(:rand).with(max).and_return(max - 1)

      # Ensure unique entries are returned
      expect(described_class).to receive(:random).exactly(max).times.and_return(unique_surname1, unique_surname2, unique_surname3)

      surnames = described_class.hyphenated(max: max, join: false)
      expect(surnames).to contain_exactly(unique_surname1, unique_surname2, unique_surname3)
    end

    it "selects a minimum of 1 surname to construct the string" do
      # Ensure the RNG receives the max but selects the min
      expect(described_class).to receive(:rand).with(max).and_return(min - 1)

      # Ensure unique entries are returned
      expect(described_class).to receive(:random).exactly(min).times.and_return(unique_surname1)

      surnames = described_class.hyphenated(max: max, join: false)
      expect(surnames).to contain_exactly(unique_surname1)
    end

    it "defaults to a `max` of 2 unique surnames" do
      # Ensure the RNG receives and then selects the default max
      expect(described_class).to receive(:rand).with(default_max).and_return(default_max - 1)

      # Ensure unique entries are returned
      expect(described_class).to receive(:random).exactly(default_max).times.and_return(unique_surname1, unique_surname2)

      surnames = described_class.hyphenated(join: false)
      expect(surnames).to contain_exactly(unique_surname1, unique_surname2)
    end

    it "removes non unique surnames" do
      # Ensure the RNG receives and then selects the default max
      expect(described_class).to receive(:rand).with(default_max).and_return(default_max - 1)

      # Ensure non-unique entries are returned
      expect(described_class).to receive(:random).exactly(default_max).times.and_return(unique_surname1, duplicate_surname)

      surnames = described_class.hyphenated(join: false)
      expect(surnames).to contain_exactly(unique_surname1)
    end

    it "joins surnames with \"-\" by default" do
      # Ensure the RNG receives and then selects the default max
      expect(described_class).to receive(:rand).with(default_max).and_return(default_max - 1)

      # Ensure unique entries are returned
      expect(described_class).to receive(:random).exactly(default_max).times.and_return(unique_surname1, unique_surname2)

      surnames = described_class.hyphenated
      expect(surnames).to eq("#{unique_surname1.value}#{default_separator}#{unique_surname2.value}")
    end

    it "can accept a different separator to join surnames on" do
      # Ensure the RNG receives and then selects the default max
      expect(described_class).to receive(:rand).with(default_max).and_return(default_max - 1)

      # Ensure unique entries are returned
      expect(described_class).to receive(:random).exactly(default_max).times.and_return(unique_surname1, unique_surname2)

      separator = ", "
      surnames = described_class.hyphenated(separator: separator)
      expect(surnames).to eq("#{unique_surname1.value}#{separator}#{unique_surname2.value}")
    end
  end
end
