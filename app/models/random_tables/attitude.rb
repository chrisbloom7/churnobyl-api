# frozen_string_literal: true
module RandomTables
  class Attitude < ApplicationYamlHash
    include RandomTable
    self.random_weight_column = :weight
  end
end
