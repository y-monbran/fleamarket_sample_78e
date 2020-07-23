FactoryBot.define do
  factory :item_img do
    url{File.open("#{Rails.root}/public/uploads/item_img/url/1/スクリーンショット_2020-05-24_23.17.41.png")}
    association :item
  end
end
