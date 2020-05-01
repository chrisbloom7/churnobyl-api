module RandomTables
  class FirstName < ActiveYaml::Base
    set_filename "random_tables/unisex_names"
    include RandomTable
  end
end
