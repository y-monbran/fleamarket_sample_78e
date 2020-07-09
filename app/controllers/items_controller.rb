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
    # @item.item_imgs.new
    @items = Item.includes(:item_imgs).order('created_at DESC') # includes(:images)だった。indexから持ってきた
    @items.new #仮
    @name = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @items.save
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
    # params.require(:item).permit(:name, :price, images_attributes: [:src])
    # params.require(:item).permit(:name, :price, item_imgs_attributes: [:src],:explain, :category, :bland, :status, :burden, :label, :text)
    params.require(:item).permit(:name, :price, item_imgs_attributes: [:src])
  end

  def set_product
    @item = Item.find(params[:id])
  end
end



 # def get_category_children
  #   #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
  #   @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  # end

  # def get_category_grandchildren
  #     #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
  #   @category_grandchildren = Category.find("#{params[:child_id]}").children
  # end