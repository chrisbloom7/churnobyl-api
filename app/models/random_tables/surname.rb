module RandomTables
  class Surname < ActiveYaml::Base
    include RandomTable

    def self.random(max = 2)
      surnames = []
      (rand(max)+1).times do
        surnames << super()
      end
      surnames.uniq.join("-")
    end
  end
end
