# frozen_string_literal: true
require "terminal-table"

class Collection < ApplicationRecord
  has_many :templates, inverse_of: :collection

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :default_label, presence: true

  def self.named(name)
    find_by(name: name)
  end

  def reset
    remove_instance_variable(:@data) if instance_variable_defined?(:@data)
    self
  end

  def execute
    return @data if instance_variable_defined?(:@data)
    @data = templates.map(&:execute)
  end

  def to_table(title: default_label, headings: nil)
    Terminal::Table.new do |t|
      t.title = title if title.present?
      t.headings = headings if headings.present?
      t.rows = execute.map(&:values)
    end.to_s
  end
end
