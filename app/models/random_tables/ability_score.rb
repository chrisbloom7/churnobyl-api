module RandomTables
  class AbilityScore < ApplicationYamlHash
    include RandomTable
    self.random_weight_column = :weight
  end
end
