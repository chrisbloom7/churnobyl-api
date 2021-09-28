# frozen_string_literal: true
class RandomTableGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)
  class_option :weighted, type: :boolean, default: false,
                          desc: "Set random_weight_column to :weight and add weights to the example data"
  class_option :random_weight_column, type: :string, default: nil, banner: :column_name,
                                      desc: "Set random_weight_column to the named column (implies --weighted)"

  def copy_random_table_file
    template "random_table_spec.rb", "spec/models/random_tables/#{file_name.singularize}_spec.rb"
    template "random_table.rb", "app/models/random_tables/#{file_name.singularize}.rb"
    template "random_table.yml", "db/random_tables/#{plural_file_name}.yml"
  end

  def weighted?
    options[:weighted] || options[:random_weight_column]
  end

  def random_weight_column
    return nil unless weighted?
    options[:random_weight_column].presence || :weight
  end
end
