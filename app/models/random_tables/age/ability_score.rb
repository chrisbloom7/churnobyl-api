# frozen_string_literal: true

module RandomTables
  module Age
    class AbilityScore < ApplicationYamlHash
      include RandomTable
      self.random_weight_column = :weight
    end
  end
end
