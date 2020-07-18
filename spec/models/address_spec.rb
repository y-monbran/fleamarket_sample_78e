require 'rails_helper'
require 'spec_helper'

describe Address do
  context 'ウィザード形式2ページ目（必須事項は埋まっていない時にエラー表示をするか）'do
    it "必須項目が間違いなく入力されていれば進める" do
      address = build(:address) 
      expect(address).to be_valid
    end

    it "郵便番号がないと進めない" do
    address = build(:address, post_code: nil)
    address.valid?
      expect(address.errors[:post_code]).to include("を入力してください")
    end

    it "都道府県がない場合は進めない" do
      address = build(:address, prefecture_code_id: nil)
      address.valid?
      expect(address.errors[:prefecture_code_id]).to include("を入力してください")
    end

    it "市区町村が入力されていないと進めない" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    it "番地が入力されていないと進めない" do
      address = build(:address, house_number: nil)
      address.valid?
      expect(address.errors[:house_number]).to include("を入力してください")
    end

  end
  
end