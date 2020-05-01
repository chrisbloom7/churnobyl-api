module RandomTables
  class Ancestry < ActiveYaml::Base
    include RandomTable

    def self.random(max = 2)
      ancestry = []
      (rand(max)+1).times do
        ancestry << super()
      end
      ancestry.uniq.join("/")
    end
  end
end
