class Category < ApplicationRecord
  has_ancestry
  validates :name, presence: true
end
