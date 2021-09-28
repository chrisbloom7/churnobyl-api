# frozen_string_literal: true

require 'rails_helper'

class RandomTables::RandomTest
  def self.random
    'random'
  end
end

class RandomTables::RandomTestTwo
  def self.random
    'random 2'
  end
end

RSpec.describe Collection, type: :model do
  let(:valid_attributes) { { name: 'c1', default_label: 'My Collection' } }

  describe '.new' do
    it 'requires a name' do
      expect(Collection.new(valid_attributes)).to be_valid
      instance = Collection.new(valid_attributes.except(:name))
      expect(instance).not_to be_valid
      expect(instance.errors.keys).to include(:name)
    end

    it 'requires name to be unique' do
      Collection.create!(valid_attributes)
      instance = Collection.new(valid_attributes)
      expect(instance).not_to be_valid
      expect(instance.errors.keys).to include(:name)
    end

    it 'requires a default_label' do
      expect(Collection.new(valid_attributes)).to be_valid
      instance = Collection.new(valid_attributes.except(:default_label))
      expect(instance).not_to be_valid
      expect(instance.errors.keys).to include(:default_label)
    end
  end

  describe '#reset' do
    subject { Collection.new(valid_attributes) }

    it 'unmemoizes the execute method' do
      template1 = Template.new(label: 'First', generator: 'RandomTest')
      allow(template1).to receive(:execute).and_return('1111', '2222')
      template2 = Template.new(label: 'Second', generator: 'RandomTestTwo')
      allow(template2).to receive(:execute).and_return('3333', '4444')
      subject.templates = [template1, template2]

      memoized = subject.execute
      expect(memoized).to eq(subject.execute)

      subject.reset
      expect(memoized).not_to eq(subject.execute)
    end

    it 'returns self' do
      expect(subject.reset).to eq(subject)
    end
  end

  describe '#execute' do
    subject do
      templates = [
        Template.new(label: 'First', generator: 'RandomTest'),
        Template.new(label: 'Second', generator: 'RandomTestTwo'),
      ]
      Collection.new(valid_attributes.merge(templates: templates))
    end

    it 'calls execute on each attached template' do
      expect(subject.execute).to be_an(Array)
      expect(subject.execute.size).to eq(2)
      expect(subject.execute[0]).to include(label: 'First', data: 'random')
      expect(subject.execute[1]).to include(label: 'Second', data: 'random 2')
    end

    it 'memoizes the executed data' do
      template1 = Template.new(label: 'First', generator: 'RandomTest')
      allow(template1).to receive(:execute).and_return('1111', '2222')
      template2 = Template.new(label: 'Second', generator: 'RandomTestTwo')
      allow(template2).to receive(:execute).and_return('3333', '4444')
      subject.templates = [template1, template2]

      memoized = subject.execute
      expect(memoized).to eq(subject.execute)
    end
  end

  describe '#to_table' do
    subject do
      templates = [
        Template.new(label: 'First', generator: 'RandomTest'),
        Template.new(label: 'Second', generator: 'RandomTestTwo'),
      ]
      Collection.new(valid_attributes.merge(templates: templates))
    end

    it 'returns a the data as an ASCII table' do
      expect(subject.to_table).to eq <<~TABLE.chomp
        +--------+----------+
        |   My Collection   |
        +--------+----------+
        | First  | random   |
        | Second | random 2 |
        +--------+----------+
      TABLE
    end

    it 'can accept a custom table title' do
      expect(subject.to_table(title: 'Different Title')).to eq <<~TABLE.chomp
        +--------+----------+
        |  Different Title  |
        +--------+----------+
        | First  | random   |
        | Second | random 2 |
        +--------+----------+
      TABLE
    end

    it 'can have no table title' do
      expect(subject.to_table(title: nil)).to eq <<~TABLE.chomp
        +--------+----------+
        | First  | random   |
        | Second | random 2 |
        +--------+----------+
      TABLE
    end

    it 'can accept a custom set of column headers' do
      expect(subject.to_table(headings: %w[One Two])).to eq <<~TABLE.chomp
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
