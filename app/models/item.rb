class Item < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, dependent: :destroy
  has_many :favorites
  has_many :item_imgs, dependent: :destroy
  belongs_to :category
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :prefecture_code
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

item = Item.new(name: "takashi", introduction: "aaaaaaaa", price:10000, postage_payer_id: 1, item_condition_id: 1, prefecture_code_id: 1, preparation_day_id: 1, category_id: 1, seller_id: 1, buyer_id: 1, created_at: nil, updated_at: nil, email: "aa@aa")
