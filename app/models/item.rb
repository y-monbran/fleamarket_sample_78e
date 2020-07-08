class Item < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :favorites
  has_many :item_imgs, dependent: :destroy
  belongs_to :category
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :preparation_day
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"

  with_options presence: true do
    validates :name
    validates :introduction
    validates :price
    validates :item_condition
    validates :postage_payer
    validates :prefecture_code
    validates :preparation_day
    validates :item_img
    validates :category
    validates :seller
  end
end