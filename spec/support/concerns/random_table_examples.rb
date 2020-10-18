require 'rails_helper'

# These methods are tested in more detail in spec/models/concerns/random_table_spec.rb.
# These examples are simple confidence checks to ensure the concern has been included.
shared_examples_for "a simple random table" do
  describe ".random" do
    it "returns a random value from the data table" do
      expect(described_class.all.map(&:value)).to include(described_class.random)
    end
  end
end
