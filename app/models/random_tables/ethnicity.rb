module RandomTables
  class Ethnicity
    include RandomTable

    TABLE = {
      1 => "African",
      2 => "Asian/South Asian",
      3 => "Caucasian",
      4 => "Latin/Indigenous/American",
      5 => "Mediterranean/Middle Eastern",
      6 => "Polynesian/Indigenous Australian",
    }

    def self.random(max = 3)
      ethinicities = []
      (rand(max)+1).times do
        ethnicity = super()
        if (choices = ethnicity.split("/")).any?
          ethnicity = choices.sample
        end
        ethinicities << ethnicity
      end
      ethinicities.join("/")
    end
  end
end
