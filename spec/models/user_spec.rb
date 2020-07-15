require 'rails_helper'
require 'spec_helper'
require 'devise'

describe User do
  context 'ウィザード形式1ページ目（必須事項は埋まっていない時にエラー表示をするか）'do
    it "必須項目が間違いなく入力されていれば進める"do
      user = build(:user) 
      expect(user).to be_valid
    end

    it "ニックネームがないと進めない"do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "メールアドレスがない場合は進めない" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
   
    it "パスワードがない場合は進めない" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "パスワードは２回入力しない場合は進めない" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "名字が入力されていないと進めない" do
      user = build(:user, family_name: nil)
      user.valid?
      expect(user.errors[:family_name]).to include("を入力してください")
    end

    it "名前が入力されていないと進めない" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end

    it "名字(カナ) が入力されていないと進めない" do
      user = build(:user, family_name_kana: nil)
      user.valid?
      expect(user.errors[:family_name_kana]).to include("を入力してください")
    end

    it "名前（カナ）が入力されていないと進めない" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end

    it "生年月日が入力されていないと進めない" do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end

  end

  context 'ウィザード形式1ページ目（誤入力時のエラー表示がされるか）'do
    it "必須項目が間違いなく入力されていれば進める"do
      user = build(:user)
      expect(user).to be_valid
    end

    it "メールアドレスが誤入力された（正規表現とあっていない）場合は進めない:devise" do
      user = build(:user, email: %w[user@foo..com user_at_foo,org example.user@foo.
        foo@bar_baz.com foo@bar+baz.com])
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "パスワードが7文字以上でないと進めない" do
      user = build(:user,password: "aaa1",password_confirmation: "aaa1")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end
    
  end
  
  context "一意性" do
    it "すでに登録されているメールアドレスは登録できない" do
      User.create(
        nickname: "フリマ",
        email: "japan@gmail.com",
        password: "japan12",
        password_confirmation: "japan12",
        family_name: "山田",
        first_name: "太郎",
        family_name_kana: "ヤマダ",
        first_name_kana: "タロウ",
        birthday: "20200523",
      )
      user = User.new(
        nickname: "フリマ子",
        email: "japan@gmail.com",
        password: "japan122",
        password_confirmation: "japan122",
        family_name: "山田",
        first_name: "花子",
        family_name_kana: "ヤマダ",
        first_name_kana: "ハナコ",
        birthday: "20200524",
      )
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end
  end
end