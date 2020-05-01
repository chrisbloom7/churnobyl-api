require 'active_support/concern'

module RandomTable
  extend ActiveSupport::Concern

  included do
    set_root_path Rails.root.join("db")
  end

  class_methods do
    # Randomly select a value from the source table.
    def random
      if self.first.attributes.keys.include?(:weight)
        sample_weighted_table
      else
        sample_table
      end
    end

    protected

    # Sample the unweighted data table
    def sample_table
      self.all.sample.value
    end

    # Map the weighted values to a flat array and sample it
    def sample_weighted_table
      weighted_table = self.all.flat_map do |entry|
        entry.weight > 1 ? Array.new(entry.weight, entry.value) : entry.value
      end
      weighted_table.sample
    end
  end
end
