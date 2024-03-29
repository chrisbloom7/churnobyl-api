# frozen_string_literal: true

module RandomTables
  class Origin < ApplicationYamlHash
    include RandomTable
    self.random_weight_column = :weight
  end
end
