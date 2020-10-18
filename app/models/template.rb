class Template < ApplicationRecord
  belongs_to :collection, inverse_of: :templates

  validates :label, :generator, presence: true
  validate :generator_must_exist

  def execute
    data = generator_klass.respond_to?(:random) ? generator_klass.random : ""
    { label: label, data: data }
  end

  private

  def generator_must_exist
    return unless generator.present?
    if generator_klass.nil?
      errors.add(:generator, "is not a valid generator name")
    elsif !generator_klass.respond_to?(:random)
      errors.add(:generator, "is not a random generator")
    end
  end

  def generator_klass
    return nil unless generator_exists?
    RandomTables.const_get(generator)
  end

  def generator_exists?
    RandomTables.const_defined?(generator) &&
      RandomTables.const_get(generator).is_a?(Class)
  rescue NameError
    false
  end
end
