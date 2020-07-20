require 'rails_helper'
require 'spec_helper'
require 'item'

describe Item do 
  describe '#create' do
    context '必要事項が埋まっていないときにエラー表示をするか' do
      it "必要事項が入力されていれば出品できる" do
        item = build(:item)
        expect(item).to be_valid
      end

      it "nameが空の場合は出品できない" do
        item = build(:item, name: nil)
        item.valid?
        expect(item.errors[:name]).to include("を入力してください")
      end

      it "nameが40文字以内でないと進めない" do
        item = build(:item, name: "a" * 41)
        item.valid?
        expect(item.errors[:name]).to include("は40文字以内で入力してください")
      end

      it "introductionが空の場合は出品できない" do
        item = build(:item, introduction: nil)
        item.valid?
        expect(item.errors[:introduction]).to include("を入力してください")
      end

      it "introductionが1000文字以内でないと進めない" do
        item = build(:item, introduction: "a" * 1001)
        item.valid?
        expect(item.errors[:introduction]).to include("は1000文字以内で入力してください")
      end

      it "priceが空の場合は出品できない" do
        item = build(:item, price: nil)
        item.valid?
        expect(item.errors[:price]).to include("を入力してください")
      end

      it "priceが300以上の値でないと進めない" do
        item = build(:item, price: 299)
        item.valid?
        expect(item.errors[:price]).to include("は300以上の値にしてください")
      end

      it "priceが9999999以下の値でないと進めない" do
        item = build(:item, price: 10000000)
        item.valid?
        expect(item.errors[:price]).to include("は9999999以下の値にしてください")
      end

      it "item_conditionがからの場合は出品できない" do
        item = build(:item, item_condition_id: nil)
        item.valid?
        expect(item.errors[:item_condition]).to include("を入力してください")
      end

      it "postege_payerが空の場合は出品できない" do
        item = build(:item, postage_payer_id: nil)
        item.valid?
        expect(item.errors[:postage_payer]).to include("を入力してください")
      end

      it "prefecture_codeが空の場合は出品できない" do
        item = build(:item, prefecture_code_id: nil)
        item.valid?
        expect(item.errors[:prefecture_code]).to include("を入力してください")
      end

      it "preparetion_dayが空の場合は出品できない" do
        item = build(:item, preparation_day_id: nil)
        item.valid?
        expect(item.errors[:preparation_day]).to include("を入力してください")
      end

      it "categoryが空の場合は出品できない" do
        item = build(:item ,:without_category)
        item.valid?
        expect(item.errors[:category]).to include("を入力してください")
      end

      it "statusが空の場合は出品できない" do
        item = build(:item, status: nil)
        item.valid?
        expect(item.errors[:status]).to include("を入力してください")
      end

      it "seller_idが空の場合は出品できない" do
        item = build(:item, seller_id: nil)
        item.valid?
        expect(item.errors[:seller]).to include("を入力してください")
      end
    end
  end
end
