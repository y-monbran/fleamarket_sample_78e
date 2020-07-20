FactoryBot.define do
  factory :user, aliases:[:seller] do
    nickname {"フリマ"}
    email{"japan@gmail.com"}
    password{"japan12"}
    password_confirmation{"japan12"}
    family_name{"山田"}
    first_name{"太郎"}
    family_name_kana{"ヤマダ"}
    first_name_kana{"タロウ"}
    birthday{20200523}
  end
end