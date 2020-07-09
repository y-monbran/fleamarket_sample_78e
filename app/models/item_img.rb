class ItemImg < ApplicationRecord
  mount_uploader :url, ItemImgUploader
  belongs_to :item
  validates :url, presence: true
  validates :item, presence: true
end
