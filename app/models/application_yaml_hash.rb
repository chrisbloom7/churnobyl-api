# frozen_string_literal: true
class ApplicationYamlHash < ActiveYaml::Base
  set_root_path Rails.root.join("db")

  def to_s
    value
  end
end
