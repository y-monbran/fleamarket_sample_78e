class ItemImg < ApplicationRecord
  belongs_to :item
  validates :url, presence: true
  validates :item, presence: true
end
