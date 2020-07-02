## usersテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|nickname|string|null: false|
|name|string|null: false|
|email|string|null false|
|password|string|null: false|
|name|string|null: false|
|birth_year|date|null: false|
|postal_code|integer|null: false|
|address|string|null: false|
|building_name|string|
|house_number|string|null: true|
|phone_number|integer|unique: true|
### Association
- has_many: products
- has_many :seller_products, foreign_key: "seller_id", class_name: "products"
- has_many :buyer_products, foreign_key: "buyer_id", class_name: "products"
- has_one :credit_card, dependent: :destroy

## productsテーブル
|Column|Type|Option|
|------|----|------|
|products_ID|string|null: false|
|products_img|references|null: false|
|products_name|string|null: false|
|price|integer|null: false|
|explain|text|null: false|
|size|references|null: false,foreign_key: true|
|category|references|null: false,foreign_key: true|
|brand|references|null: false,foreign_key: true|
|products_condition|references|null: false,foreign_key: true|
|trading_status|enum|null: false|
|postage_type|references|null: false,foreign_key: true|
|postage_payer|references|null: false,foreign_key: true|
|prefecture_code|integer|null: false|
|preparation_day|integer|null: false|
|seller|references|null: false, foreign_key: true|
|buyer|references|foreign_key: true|
|deal_closed_date|timestamp|
## Association
- has_many :product_imgs, dependent: :destroy
- belongs_to :category
- belongs_to :brand
- belongs_to_active_hash :size
- belongs_to_active_hash :product_condition
- belongs_to_active_hash :postage_payer
- belongs_to_active_hash :preparation_day
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"
- Gem：jp_prefectureを使用して都道府県コードを取得

## areaテーブル
|Column|Type|Option|
|------|----|------|
|products_ID|references|foreign_key: true|
|user_id|references|foreign_key: true|
|postage_payer|references|null: false,foreign_key: true|
|prefecture_code|integer|null: false|
|preparation_day|integer|null: false|
## Association
- belongs_to :user
- belongs_to :products
- belongs_to_active_hash :preparation_day

## historyテーブル
|Column|Type|Option|
|------|----|------|
|products_ID|references|foreign_key: true|
|user_id|references|foreign_key: true|
|buyer|references|foreign_key: true|
|seller|references|null: false, foreign_key: true|
|trading_date|timestamp|
## Association
- belongs_to :user
- belongs_to :product
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"


## credit_cardテーブル
|Column|Type|Option|
|------|----|------|
|user|references|null: false, foreign_key: true|
|card_number|integer|null:false, unique: true|
|expiration_year|integer| null:false|
|expiration_month|integer| null:false|
|security_code|integer| null:false|
### Association
- belongs_to :user


