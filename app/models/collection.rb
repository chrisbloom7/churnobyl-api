class Collection < ApplicationRecord
  has_many :templates, inverse_of: :collection
end
