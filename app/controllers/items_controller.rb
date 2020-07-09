class ItemsController < ApplicationController
  def index
    @items = Item.includes(:item_imgs).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.item_imgs.new
  end

  def create
    @item = Item.new(item_params)
    # binding.pry
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end
  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :postage_payer_id, :item_condition_id, :prefecture_code_id, :preparation_day_id, item_imgs_attributes: [:url])
  end

end
