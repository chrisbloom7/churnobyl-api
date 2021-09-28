# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rollers::Challenge, type: :model do
  describe '.drama' do
    let(:challenge) { described_class.drama }

    it 'returns an array with two elements' do
      expect(challenge).to be_an(Array)
      expect(challenge.size).to eq(2)
    end

    it 'rolls 3d6' do
      expect(described_class).to receive(:d6).thrice
      challenge
    end

    it 'has two normal d6 results as the first element' do
      expect(challenge[0]).to be_an(Array)
      expect(challenge[0].size).to eq(2)
      expect(challenge[0][0]).to be_an(Integer)
      expect(challenge[0][0]).to be_an(Integer)
    end

    it 'has an extra d6 result as the second element' do
      expect(challenge[1]).to be_an(Integer)
    end
  end

  describe '.roll' do
    let(:challenge) { described_class.roll }

    it 'returns an array with three results' do
      expect(challenge).to be_an(Array)
      expect(challenge.size).to eq(3)
      expect(challenge[0]).to be_an(Integer)
      expect(challenge[1]).to be_an(Integer)
      expect(challenge[2]).to be_an(Integer)
    end

    it 'rolls 3d6' do
      expect(described_class).to receive(:d6).thrice
      challenge
    end

    it 'sorts the results from low to high' do
      expect(described_class).to receive(:d6).and_return(3, 6, 1)
      expect(challenge[0]).to eq(1)
      expect(challenge[1]).to eq(3)
      expect(challenge[2]).to eq(6)
    end
  end

  describe '.simple' do
    let(:challenge) { described_class.simple }

    it 'returns an integer' do
      expect(challenge).to be_an(Integer)
    end

    it 'rolls 3d6' do
      expect(described_class).to receive(:d6).thrice.and_call_original
      challenge
    end

    it 'returns the sum of three d6 results' do
      expect(described_class).to receive(:d6).and_return(1, 3, 6)
      expect(challenge).to eq(10)
    end
  end

  describe '.drop' do
    let(:challenge) { described_class.drop }

    it 'returns an array' do
      expect(challenge).to be_an(Array)
    end

    it 'rolls 4d6' do
      expect(described_class).to receive(:d6).exactly(4).times
      challenge
    end

    it 'returns the highest three d6 results' do
      expect(described_class).to receive(:d6).and_return(1, 3, 6, 9)
      expect(challenge).to contain_exactly(3, 6, 9)
    end
  end
end
