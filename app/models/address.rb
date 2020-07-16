class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture_code
  belongs_to :user, optional: true

  validates :post_code, presence: true
  validates :prefecture_code_id, presence: true
  validates :city, presence: true
  validates :house_number, presence: true
end
