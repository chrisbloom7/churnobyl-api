# frozen_string_literal: true

module RandomTables
  extend self

  # All discoverable random tables should be listed here
  REGISTRY = [
    Age::AbilityScore,
    AgeGroup,
    Ancestry,
    Attitude,
    FirstName,
    GenderExpression,
    HyphenatedSurname,
    MixedAncestry,
    Origin,
    Surname,
  ]

  def klass(generator)
    return nil unless exists?(generator)
    RandomTables.const_get(generator)
  end

  def exists?(generator)
    RandomTables.const_defined?(generator) &&
      RandomTables.const_get(generator).is_a?(Class)
  rescue NameError
    false
  end
end
