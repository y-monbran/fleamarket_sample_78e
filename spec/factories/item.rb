FactoryBot.define do
  factory :item do
    name{"アイフォン"}
    introduction{"スマートフォンです"}
    price{9999}
    item_condition_id{1}
    postage_payer_id{1}
    prefecture_code_id{1}
    preparation_day_id{1}
    # category_id{1}
    created_at{2020-07-16}
    updated_at{2020-07-16}
    status{1}

    association :category

    after(:build) do |i|
      i.item_imgs << [build(:item_img, item: nil)]
      i.category = build(:category)
    end

    trait :without_category do
      after(:build) do |item|
        item.category = nil
      end
    end

  end
end
