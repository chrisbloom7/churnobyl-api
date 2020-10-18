class Collection < ApplicationRecord
  has_many :templates, inverse_of: :collection

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :default_label, presence: true

  def execute
    templates.map(&:execute)
  end
end
