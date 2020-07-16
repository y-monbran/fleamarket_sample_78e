class ItemsController < ApplicationController

  before_action :set_category, only: [:new, :create]

  def index
    @items = Item.select("name", "price").first(4)
    @items = Item.includes(:item_imgs).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.item_imgs.new
    @category_parent =  Category.where("ancestry is null")
  end

  def category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @items = Item.find(params[:id])
  end

  # def buy
  # end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :postage_payer_id, :item_condition_id, :prefecture_code_id, :preparation_day_id, :category_id, item_imgs_attributes: [:url])
  end

  def set_category
    @category_parent = Category.all
  end
end
