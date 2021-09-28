# frozen_string_literal: true
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
    RandomTables.klass(generator)
  end
end
