class ItemImgsController < ApplicationController
  def index
    @item_imgs = Item_Img.select("item").first(4)
  end
end
