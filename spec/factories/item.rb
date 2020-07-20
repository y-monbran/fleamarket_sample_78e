FactoryBot.define do
  factory :item do
    name{"アイフォン"}
    introduction{"スマートフォンです"}
    price{9999}
    item_condition_id{1}
    postage_payer_id{1}
    prefecture_code_id{1}
    preparation_day_id{1}
    status{1}

    association :category
    association :seller

    after(:build) do |i|
      i.item_imgs << [build(:item_img, item: nil)]
      i.category = build(:category)
      # i.seller_id = build(:seller_id)
      # i.buyer_id = build(:buyer_id)
    end

    trait :without do
      after(:build) do |item|
        item.category = nil
        # item.seller = nil
        # item.buyer = nil
      end
    end

  end
end
