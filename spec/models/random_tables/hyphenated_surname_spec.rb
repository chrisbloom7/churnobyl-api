# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RandomTables::HyphenatedSurname, type: :model do
  describe '.random' do
    let(:default_max) { 2 }
    let(:max) { 3 }
    let(:min) { 1 }
    let(:default_separator) { '-' }
    let(:unique_surname1) { 'unique_surname1' }
    let(:unique_surname2) { 'unique_surname2' }
    let(:unique_surname3) { 'unique_surname3' }
    let(:duplicate_surname) { unique_surname1 }
    let(:super_class) { RandomTables::Surname }

    it 'selects random surnames using superclass' do
      expect(super_class).to receive(:random).at_least(:once).and_call_original
      described_class.random
    end

    it 'returns a hyphenated string by default' do
      # Ensure the RNG receives and then selects the max
      expect(described_class).to receive(:weighted_random_count).and_return(default_max)

      # Ensure unique entries are returned
      expect(super_class).to receive(:random).exactly(default_max).times.and_return(unique_surname1, unique_surname2)

      expect(described_class.random).to eq("#{unique_surname1}-#{unique_surname2}")
    end

    it 'can return an array of surnames instead' do
      # Ensure the RNG receives and then selects the max
      expect(described_class).to receive(:weighted_random_count).and_return(default_max)

      # Ensure unique entries are returned
      expect(super_class).to receive(:random).exactly(default_max).times.and_return(unique_surname1, unique_surname2)

      surnames = described_class.random(join: false)
      expect(surnames).to be_an(Array)
      expect(surnames).to contain_exactly(unique_surname1, unique_surname2)
    end

    it 'selects at least `max` random surnames to construct the string' do
      # Ensure the RNG receives and then selects the max
      expect(described_class).to receive(:weighted_random_count).and_return(max)

      # Ensure unique entries are returned
      expect(super_class).to receive(:random).exactly(max).times.and_return(unique_surname1, unique_surname2, unique_surname3)

      surnames = described_class.random(max: max, join: false)
      expect(surnames).to contain_exactly(unique_surname1, unique_surname2, unique_surname3)
    end

    it 'will try up to 3 times to select `max` unique surnames' do
      # Ensure the RNG receives and then selects the max
      expect(described_class).to receive(:weighted_random_count).and_return(max)

      # Ensure NON-unique entries are returned
      #               1st attempt +    2nd attempt +        3rd attempt + ...
      # Num calls to random = max + (max - unique) + (max - new unique) + ...
      #                         3 +              2 +                  1
      count = (described_class::MAX_UNIQUE_ATTEMPTS * max) - 2 - 1
      expect(super_class).to receive(:random).exactly(count).times.and_return(unique_surname1, unique_surname1, unique_surname1, unique_surname2)

      described_class.random(max: max, join: false)
    end

    it 'selects a minimum of 1 surname to construct the string' do
      # Ensure the RNG receives the max but selects the min
      expect(described_class).to receive(:weighted_random_count).and_return(min)

      # Ensure unique entries are returned
      expect(super_class).to receive(:random).exactly(min).times.and_return(unique_surname1)

      surnames = described_class.random(max: max, join: false)
      expect(surnames).to contain_exactly(unique_surname1)
    end

    it 'removes non unique surnames' do
      # Ensure the RNG receives and then selects the default max
      expect(described_class).to receive(:weighted_random_count).and_return(default_max)

      # Ensure non-unique entries are returned
      expect(super_class).to receive(:random).exactly(default_max + 1).times.and_return(unique_surname1, duplicate_surname, unique_surname3)

      surnames = described_class.random(join: false)
      expect(surnames).to contain_exactly(unique_surname1, unique_surname3)
    end

    it 'can accept a different separator to join surnames on' do
      # Ensure the RNG receives and then selects the default max
      expect(described_class).to receive(:weighted_random_count).and_return(default_max)

      # Ensure unique entries are returned
      expect(super_class).to receive(:random).exactly(default_max).times.and_return(unique_surname1, unique_surname2)

      separator = ', '
      surnames = described_class.random(separator: separator)
      expect(surnames).to eq("#{unique_surname1}#{separator}#{unique_surname2}")
    end

    it 'can adjust the chance of getting more than 1 surname' do
      1000.times do
        # Always 1
        expect(described_class.random(weight: 0, join: false).size).to eq(1)

        # Always more than 1
        expect(described_class.random(weight: 1, join: false).size).to eq(2)
      end
    end

    it 'raises an error if the max is less than 1' do
      expect {
        described_class.random(max: 0)
      }.to raise_error('Invalid max (must be between 1 and 100)')
    end

    it 'raises an error if the max is greater than 100' do
      expect {
        described_class.random(max: 101)
      }.to raise_error('Invalid max (must be between 1 and 100)')
    end

    it 'raises an error if the weight is less than 0' do
      expect {
        described_class.random(weight: -1)
      }.to raise_error('Invalid weight (must be between 0.0 and 1)')
    end

    it 'raises an error if the weight is greater than 1' do
      expect {
        described_class.random(weight: 1.1)
      }.to raise_error('Invalid weight (must be between 0.0 and 1)')
    end
  end
end
