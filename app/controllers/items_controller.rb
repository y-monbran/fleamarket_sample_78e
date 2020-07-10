class ItemsController < ApplicationController
  def index
  end
  def show
    @item = Item.find(params[:id])
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end
end