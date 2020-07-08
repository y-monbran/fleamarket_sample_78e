class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]

  def index
    @items = Item.includes(:item_imgs).order('created_at DESC') # includes(:images)だった
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @item.item_img.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, images_attributes: [:src])
  end

  def set_product
    @item = Item.find(params[:id])
  end
end
