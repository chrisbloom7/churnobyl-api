class YamlRecord < ActiveYaml::Base
  self.abstract_class = true
  set_root_path Rails.root.join("db", "tables")
end
