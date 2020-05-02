module RandomTables
  class <%= class_name %> < ApplicationYamlHash
    include RandomTable<%- if weighted? %>
    self.random_weight_column = :<%= random_weight_column %><% end %>
  end
end
