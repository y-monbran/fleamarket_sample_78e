class ItemsController < ApplicationController

  before_action :set_category, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :destroy, :edit, :update]

  def index
    @items = Item.includes(:item_imgs).limit(4).order('created_at DESC')
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
    else
      @item.item_imgs.new
      @category_parent =  Category.where("ancestry is null")
      render :new
    end
  end

  def show
  end

  def edit
    @category_parent =  Category.where("ancestry is null")
  end

  def update
    if @item.update(item_params)
    else
      @category_parent =  Category.where("ancestry is null")
      render :edit
    end
  end

  def destroy
    @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :postage_payer_id, :item_condition_id, :prefecture_code_id, :preparation_day_id, :category_id, item_imgs_attributes: [:url, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_category
    @category_parent = Category.all
  end
end
