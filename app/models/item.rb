class Item < ApplicationRecord
  # has_many :comments, dependent: :destroy
  # has_many :favorites
  has_many :item_imgs, dependent: :destroy
  belongs_to :category
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :prefecture_code
  belongs_to_active_hash :preparation_day
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true

  accepts_nested_attributes_for :item_imgs, allow_destroy: true

  with_options presence: true do
    validates :name
    validates :introduction
    validates :price
    validates :item_condition
    validates :postage_payer
    validates :prefecture_code
    validates :preparation_day
    validates :item_imgs
    validates :category
    validates :seller
    validates :status
  end

  enum status: {
    sale: 1,
    sold: 2
  }

  validate :item_imgs_number

  private

  def item_imgs_number
    errors.add(:item_imgs, "を1つ以上指定して下さい") if item_imgs.size < 1
    errors.add(:item_imgs, "は3個までです") if item_imgs.size > 3
  end

end