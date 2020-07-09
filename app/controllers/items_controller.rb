class ItemsController < ApplicationController

  before_action :set_categories, only: [edit new]

  def index
    @items = Item.select("name", "price").first(4)
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
    @items = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :postage_payer_id, :item_condition_id, :prefecture_code_id, :preparation_day_id, item_imgs_attributes: [:url])
  end

  def set_categories
    @parent_categories = Category.roots
    @default_child_categories = @parent_categories.first.children
    @default_grandchild_categories = @default_child_categories.first.children
   end

end
