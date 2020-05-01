require 'rails_helper'

# These methods are tested in more detail in spec/models/concerns/random_table_spec.rb.
# These examples are simple sanity checks to ensure the concern has been included.
shared_examples_for "random_table" do
  describe ".random" do
    it "returns a random instance" do
      expect(described_class.random).to be_an_instance_of(described_class)
    end
  end
end
