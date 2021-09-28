# frozen_string_literal: true

require 'rails_helper'

module RandomTables
  class RandomTest
    def self.random
      'random'
    end
  end

  class NonRandomTest; end # rubocop:disable Lint/EmptyClass
end

RSpec.describe Template, type: :model do
  let(:collection) { Collection.new }
  let(:valid_attributes) { { collection: collection, label: 'Test', generator: 'RandomTest' } }

  describe '.new' do
    it 'requires an associated collection' do
      expect(described_class.new(valid_attributes)).to be_valid
      template = described_class.new(valid_attributes.except(:collection))
      expect(template).not_to be_valid
      expect(template.errors.keys).to include(:collection)
    end

    it 'requires a label' do
      expect(described_class.new(valid_attributes)).to be_valid
      template = described_class.new(valid_attributes.except(:label))
      expect(template).not_to be_valid
      expect(template.errors.keys).to include(:label)
    end

    it 'requires a generator' do
      expect(described_class.new(valid_attributes)).to be_valid
      template = described_class.new(valid_attributes.except(:generator))
      expect(template).not_to be_valid
      expect(template.errors.keys).to include(:generator)
    end

    it 'requires generator be a valid constant name' do
      template = described_class.new(valid_attributes.merge(generator: 'random'))
      expect(template).not_to be_valid
      expect(template.errors.keys).to include(:generator)
    end

    it 'requires generator represents a real class in RandomTables' do
      expect(described_class.new(valid_attributes)).to be_valid
      template = described_class.new(valid_attributes.merge(generator: 'ZzzZzzZzz'))
      expect(template).not_to be_valid
      expect(template.errors.keys).to include(:generator)
    end

    it 'requires generator class responds to `.random`' do
      expect(described_class.new(valid_attributes)).to be_valid
      template = described_class.new(valid_attributes.merge(generator: 'NonRandomTest'))
      expect(template).not_to be_valid
      expect(template.errors.keys).to include(:generator)
    end
  end

  describe '#execute' do
    let(:template) { described_class.new(valid_attributes).execute }

    it 'calls `.random` on the generator class' do
      expect(RandomTables::RandomTest).to receive(:random)
      template
    end

    it 'returns a hash of the label and the generator data' do
      expect(template).to be_a(Hash)
      expect(template[:label]).to eq(valid_attributes[:label])
      expect(template[:data]).to eq(RandomTables::RandomTest.random)
    end

    it 'returns no data if the generator class no longer represents a real class in RandomTables' do
      template = described_class.new(valid_attributes.merge(generator: 'ZzzZzzZzz')).execute
      expect(template).to be_a(Hash)
      expect(template[:label]).to eq(valid_attributes[:label])
      expect(template[:data]).to eq('')
    end

    it 'returns no data if the generator class no longer responds to `.random`' do
      template = described_class.new(valid_attributes.merge(generator: 'NonRandomTest')).execute
      expect(template).to be_a(Hash)
      expect(template[:label]).to eq(valid_attributes[:label])
      expect(template[:data]).to eq('')
    end
  end
end
