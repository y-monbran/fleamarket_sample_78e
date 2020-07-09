class ItemsController < ApplicationController
  def index
    @items = Item.select("name", "price").first(4)
  end
  def show
    @items = Item.find(params[:id])
  end

end
