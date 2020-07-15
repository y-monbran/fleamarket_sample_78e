## usersテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false|
|nickname|string|null: false|
|email|string|null false|
|password|string|null: false|
|first_name|string|null: false|
|family_name|string|null: false|
|first_name_kana|string|null: false|
|family_name_kana|string|null: false|
|birthday|date|null: false|

### Association
- has_many: profiles, dependent: :destroy
- has_many: comments, dependent: :destroy
- has_many: histories, dependent: :destroy
- has_many :seller_items, foreign_key: "seller_id", class_name: "items"
- has_many :buyer_items, foreign_key: "buyer_id", class_name: "items"
- has_one :credit_card, dependent: :destroy


## addressesテーブル

|first_name|string|null: false|
|family_name|string|null: false|
|first_name_kana|string|null: false|
|family_name_kana|string|null: false|
|post_code|integer(7)|null: false|
|prefecture_code|integer|null: false|
|city|string|null: false|
|house_number|string|null: true|
|building_name|string|------|
|phone_number|string|unique: true|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- Gem：jp_prefecture

## itemsテーブル
|Column|Type|Option|
|------|----|------|
|id|string|null: false|
|name|string|null: false|
|introduction|text|null: false|
|price|integer|null: false|
<!-- |brand|references|foreign_key: true| -->
|item_condition|references|null: false, foreign_key: true|
|postage_payer|references|null: false, foreign_key: true|
|prefecture_code|references|null: false, foreign_key: true|
<!-- |size|references|null: false, foreign_key: true| -->
|preparation_day|references|null: false, foreign_key: true|
<!-- |postage_type|references|null: false, foreign_key: true| -->
<!-- |item_img|references|null: false, foreign_key: true| -->
|category|references|null: false, foreign_key: true|
|status|enum|null: false|
|seller|references|null: false, foreign_key: true|
|buyer|references|foreign_key: true|

## Association
- has_many :comments, dependent: :destroy
- has_many :favorites
- has_many :item_imgs, dependent: :destroy
- belongs_to :category
<!-- - belongs_to_active_hash :size -->
- belongs_to_active_hash :item_condition
- belongs_to_active_hash :postage_payer
- belongs_to_active_hash :preparation_day
<!-- - belongs_to_active_hash :postage_type -->
<!-- - belongs_to :brand -->
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"
- Gem：jp_prefecture


## commentsテーブル
|Column|Type|Option|
|------|----|------|
|comment|text|null: false|
|user|references|null: false, foreign_key: true|
|item|references|null: false foreign_key: true|

## Association
- belongs_to :user
- belongs_to :item


## item_imgsテーブル
|Column|Type|Option|
|------|----|------|
|url|string|null: false|
|item|references|null: false, foreign_key: true|

## Association
- belongs_to :item


## brandsテーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|

## Association
- has_many :items


## categoriesテーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|

## Association
- has_many :items


## favoritesテーブル
|Column|Type|Option|
|------|----|------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

## Association
- belongs_to :user
- belongs_to :item


## credit_cardsテーブル
|Column|Type|Option|
|------|----|------|
|card_num|integer|null:false, unique: true|
|expiration_year|integer|null:false|
|expiration_month|integer|null:false|
|security_code|integer|null:false|
|user_id|references|null:false, foreign_key: true|

### Association
- belongs_to :user
