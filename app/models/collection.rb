require "terminal-table"

class Collection < ApplicationRecord
  has_many :templates, inverse_of: :collection

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :default_label, presence: true

  def self.named(name)
    find_by(name: name)
  end

  def execute
    return @data if defined?(@data)
    @data = templates.map(&:execute)
  end

  def to_json(title: default_label)
    data = {}
    data[:title] = title if title.present?
    data[:data] = execute

    data.to_json
  end

  def to_table(title: default_label, headings: nil)
    Terminal::Table.new do |t|
      t.title = title if title.present?
      t.headings = headings if headings.present?
      t.rows = execute.map(&:values)
    end.to_s
  end
end
