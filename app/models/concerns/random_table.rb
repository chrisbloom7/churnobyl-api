# frozen_string_literal: true

require 'active_support/concern'

module RandomTable
  extend ActiveSupport::Concern

  included do
    class_attribute :random_id_column, default: :id
    class_attribute :random_weight_column
  end

  class_methods do
    # Randomly select a record from the source data. In order to be compatible with the most datasources
    # it plucks all of the ids from the source and picks one at random. This has the downside of not being
    # efficient with very large datasets.
    #
    # Returns a random instance of the including class
    def random
      if random_weight_column?
        sample_weighted_table
      else
        sample_table
      end
    end

    # Internal: Contruct a list of weighted ids, where ids will appear a number of times equal to their
    # weight.
    #
    # Returns an array of weighted IDs
    def weighted_ids
      raise ArgumentError, "#{name}.random_weight_column is not set" unless random_weight_column?
      pluck(random_id_column, random_weight_column).flat_map do |id, weight|
        weight = weight.present? ? weight.to_i : 1
        weight.to_i > 1 ? Array.new(weight, id) : id
      end
    end

    protected

    # Sample the unweighted data table
    def sample_table
      ids = pluck(random_id_column)
      find(ids.sample)&.value
    end

    # Map the weighted values to a flat array and sample it
    def sample_weighted_table
      ids = weighted_ids
      find(ids.sample)&.value
    end
  end
end
