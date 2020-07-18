require 'rails_helper'
require 'spec_helper'
require 'item_img'

describe ItemImg do
  describe '#create' do
    context '必要事項が埋まっていないときにエラー表示をするか' do
      it "必要事項が埋まっていれば画像を登録できる" do
        item_img = build(:item_img)
        expect(item_img).to be_valid
      end
      it "urlが空の場合は画像を登録できない" do
        item_img = build(:item_img, url: "")
        item_img.valid?
        expect(item_img.errors[:url]).to include("を入力してください")
      end

      it "itemが空の場合は画像を登録できない" do
        item_img = build(:item_img, item_id: nil)
        item_img.valid?
        expect(item_img.errors[:item]).to include("を入力してください")
      end
    end
  end
end