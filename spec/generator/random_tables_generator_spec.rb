require 'rails_helper'
require "generator_spec"
require 'generators/random_table/random_table_generator'

RSpec.describe RandomTableGenerator, type: :generator do
  destination File.expand_path("../../../tmp/spec", __FILE__)

  before do
    prepare_destination
    run_generator generator_arguments
  end

  context "with no options" do
    let(:generator_arguments) { %w(something) }

    it "creates a random table model" do
      assert_file "app/models/random_tables/something.rb" do |content|
        assert_match(/^module RandomTables$/, content)
        assert_match(/^  class Something < ApplicationYamlHash$/, content)
        assert_match(/^    include RandomTable$/, content)
        refute_match(/self.random_weight_column/, content)
      end
    end

    it "creates a random table model spec" do
      assert_file "spec/models/random_tables/something_spec.rb" do |content|
        assert_match(/^RSpec.describe RandomTables::Something, type: :model/, content)
        assert_match(/^  it_behaves_like "random_table"$/, content)
      end
    end

    it "creates a random table yaml file" do
      assert_file "db/random_tables/somethings.yml" do |content|
        assert_match(/^- value: Something1$/, content)
        assert_match(/^- value: Something2$/, content)
        assert_match(/^- value: Something3$/, content)
        refute_match(/weight:/, content)
      end
    end
  end

  context "with the --weighted option" do
    let(:generator_arguments) { %w(something --weighted) }

    it "creates a random table model with random_weight_column set to :weight" do
      assert_file "app/models/random_tables/something.rb" do |content|
        assert_match(/^module RandomTables$/, content)
        assert_match(/^  class Something < ApplicationYamlHash$/, content)
        assert_match(/^    include RandomTable$/, content)
        assert_match(/^    self.random_weight_column = :weight$/, content)
      end
    end

    it "creates a random table yaml file" do
      assert_file "db/random_tables/somethings.yml" do |content|
        assert_match(/^- value: Something1$/, content)
        assert_match(/^- value: Something2$/, content)
        assert_match(/^- value: Something3$/, content)
        assert_match(/^  weight: 1$/, content)
      end
    end
  end

  context "with the --random_weight_column=weight_column option" do
    let(:generator_arguments) { %w(something --random_weight_column=weight_column) }

    it "creates a random table model with random_weight_column set to :weight_column" do
      assert_file "app/models/random_tables/something.rb" do |content|
        assert_match(/^module RandomTables$/, content)
        assert_match(/^  class Something < ApplicationYamlHash$/, content)
        assert_match(/^    include RandomTable$/, content)
        assert_match(/^    self.random_weight_column = :weight_column$/, content)
      end
    end

    it "creates a random table yaml file" do
      assert_file "db/random_tables/somethings.yml" do |content|
        assert_match(/^- value: Something1$/, content)
        assert_match(/^- value: Something2$/, content)
        assert_match(/^- value: Something3$/, content)
        assert_match(/^  weight: 1$/, content)
      end
    end
  end
end
