# frozen_string_literal: true

require 'rails_helper'

class ExampleTable < ActiveHash::Base
  include RandomTable
  self.data = [
    { id: 1, weight: 1, value: 'one' },
    { id: 2, weight: 2, value: 'two' },
    { id: 3, weight: 3, value: 'three' },
  ]
end

RSpec.describe RandomTable, type: :concern do
  before do
    @default_data = ExampleTable.data.dup
    @default_random_id_column = ExampleTable.random_id_column
    @default_random_weight_column = ExampleTable.random_weight_column
  end

  after do
    ExampleTable.random_id_column = @default_random_id_column
    ExampleTable.random_weight_column = @default_random_weight_column
    ExampleTable.data = @default_data
  end

  describe '.random_id_column' do
    let(:random_id_column) { "id_column_#{Time.now.utc.to_f}" }

    it 'allows setting a random_id_column class attribute' do
      ExampleTable.random_id_column = random_id_column
      expect(ExampleTable.random_id_column).to eq(random_id_column)
    end

    it 'defaults random_id_column to :id' do
      expect(ExampleTable.random_id_column).to eq(:id)
    end
  end

  describe '.random_weight_column' do
    let(:random_weight_column) { "weight_column_#{Time.now.utc.to_f}" }

    it 'allows setting a random_weight_column class attribute' do
      ExampleTable.random_weight_column = random_weight_column
      expect(ExampleTable.random_weight_column).to eq(random_weight_column)
    end

    it 'defaults random_weight_column to nil' do
      expect(ExampleTable.random_weight_column).to be_nil
    end
  end

  describe '.random' do
    it 'returns a random value' do
      expect(ExampleTable.random).to be_a(String)
    end

    context 'when random_weight_column is set' do
      let(:weighted_ids) { [1, 2, 2, 3, 3, 3] }
      let(:sampled_id) { 1 }

      before do
        ExampleTable.random_weight_column = :weight
      end

      it 'can use a weighted array of IDs to select a random value' do
        expect(ExampleTable).to receive(:weighted_ids).and_return(weighted_ids)
        expect(weighted_ids).to receive(:sample).and_return(sampled_id)
        expect(ExampleTable).to receive(:find).with(sampled_id)
        ExampleTable.random
      end
    end

    context 'when random_weight_column is not set' do
      let(:plucked_data) { [1, 2, 3, 4] }
      let(:sampled_id) { 1 }

      it 'uses unweighted IDs to select a random record' do
        expect(ExampleTable).to receive(:pluck).with(:id).and_return(plucked_data)
        expect(ExampleTable).not_to receive(:weighted_ids)
        expect(plucked_data).to receive(:sample).and_return(sampled_id)
        expect(ExampleTable).to receive(:find).with(sampled_id)
        ExampleTable.random
      end
    end
  end

  describe '.weighted_ids' do
    context 'when random_weight_column is not set' do
      it 'raises an error' do
        expect {
          ExampleTable.weighted_ids
        }.to raise_error(ArgumentError, 'ExampleTable.random_weight_column is not set')
      end
    end

    context 'when random_weight_column is set' do
      before do
        ExampleTable.random_weight_column = :weight
      end

      it 'plucks the random_id_column and random_weight_column columns from the data' do
        expect(ExampleTable).to receive(:pluck).with(:id, :weight).and_return([])
        ExampleTable.weighted_ids
      end

      it 'returns an array where ids will appear a number of times equal to their weight' do
        expect(ExampleTable.weighted_ids).to contain_exactly(1, 2, 2, 3, 3, 3)
      end

      it 'defaults to a weight of 1 if no weight is provided' do
        ExampleTable.data = @default_data + [{ id: 4 }]
        expect(ExampleTable.weighted_ids).to contain_exactly(1, 2, 2, 3, 3, 3, 4)
      end

      it 'converts weights to integers' do
        ExampleTable.data = @default_data + [
          { id: 4, weight: 'a' },
          { id: 5, weight: '2' },
          { id: 6, weight: 0.5 }
        ]
        expect(ExampleTable.weighted_ids).to contain_exactly(1, 2, 2, 3, 3, 3, 4, 5, 5, 6)
      end
    end
  end
end
