FactoryBot.define do
  factory :address do
    post_code {1234567}
    prefecture_code_id{1}
    city{"札幌市中央区"}
    house_number{"12-1"}
    building_name{"あああ105"}
    phone_number{"090-1234-5678"}
  end
end