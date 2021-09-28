# frozen_string_literal: true

require 'rails_helper'

module RandomTables
  class RandomTest
    def self.random
      'random'
    end
  end

  class RandomTestTwo
    def self.random
      'random 2'
    end
  end
end

RSpec.describe Collection, type: :model do
  let(:valid_attributes) { { name: 'c1', default_label: 'My Collection' } }

  describe '.new' do
    it 'requires a name' do
      expect(described_class.new(valid_attributes)).to be_valid
      collection = described_class.new(valid_attributes.except(:name))
      expect(collection).not_to be_valid
      expect(collection.errors.keys).to include(:name)
    end

    it 'requires name to be unique' do
      described_class.create!(valid_attributes)
      collection = described_class.new(valid_attributes)
      expect(collection).not_to be_valid
      expect(collection.errors.keys).to include(:name)
    end

    it 'requires a default_label' do
      expect(described_class.new(valid_attributes)).to be_valid
      collection = described_class.new(valid_attributes.except(:default_label))
      expect(collection).not_to be_valid
      expect(collection.errors.keys).to include(:default_label)
    end
  end

  describe '#reset' do
    let(:collection) { described_class.new(valid_attributes) }

    it 'unmemoizes the execute method' do
      template1 = Template.new(label: 'First', generator: 'RandomTest')
      allow(template1).to receive(:execute).and_return('1111', '2222')
      template2 = Template.new(label: 'Second', generator: 'RandomTestTwo')
      allow(template2).to receive(:execute).and_return('3333', '4444')
      collection.templates = [template1, template2]

      memoized = collection.execute
      expect(memoized).to eq(collection.execute)

      collection.reset
      expect(memoized).not_to eq(collection.execute)
    end

    it 'returns self' do
      expect(collection.reset).to eq(collection)
    end
  end

  describe '#execute' do
    let(:collection) do
      templates = [
        Template.new(label: 'First', generator: 'RandomTest'),
        Template.new(label: 'Second', generator: 'RandomTestTwo')
      ]
      described_class.new(valid_attributes.merge(templates: templates))
    end

    it 'calls execute on each attached template' do
      expect(collection.execute).to be_an(Array)
      expect(collection.execute.size).to eq(2)
      expect(collection.execute[0]).to include(label: 'First', data: 'random')
      expect(collection.execute[1]).to include(label: 'Second', data: 'random 2')
    end

    it 'memoizes the executed data' do
      template1 = Template.new(label: 'First', generator: 'RandomTest')
      allow(template1).to receive(:execute).and_return('1111', '2222')
      template2 = Template.new(label: 'Second', generator: 'RandomTestTwo')
      allow(template2).to receive(:execute).and_return('3333', '4444')
      collection.templates = [template1, template2]

      memoized = collection.execute
      expect(memoized).to eq(collection.execute)
    end
  end

  describe '#to_table' do
    let(:collection) do
      templates = [
        Template.new(label: 'First', generator: 'RandomTest'),
        Template.new(label: 'Second', generator: 'RandomTestTwo')
      ]
      described_class.new(valid_attributes.merge(templates: templates))
    end

    it 'returns a the data as an ASCII table' do
      expect(collection.to_table).to eq <<~TABLE.chomp
        +--------+----------+
        |   My Collection   |
        +--------+----------+
        | First  | random   |
        | Second | random 2 |
        +--------+----------+
      TABLE
    end

    it 'can accept a custom table title' do
      expect(collection.to_table(title: 'Different Title')).to eq <<~TABLE.chomp
        +--------+----------+
        |  Different Title  |
        +--------+----------+
        | First  | random   |
        | Second | random 2 |
        +--------+----------+
      TABLE
    end

    it 'can have no table title' do
      expect(collection.to_table(title: nil)).to eq <<~TABLE.chomp
        +--------+----------+
        | First  | random   |
        | Second | random 2 |
        +--------+----------+
      TABLE
    end

    it 'can accept a custom set of column headers' do
      expect(collection.to_table(headings: %w[One Two])).to eq <<~TABLE.chomp
        +--------+----------+
        |   My Collection   |
        +--------+----------+
        | One    | Two      |
        +--------+----------+
        | First  | random   |
        | Second | random 2 |
        +--------+----------+
      TABLE
    end
  end
end
