class ItemsController < ApplicationController
  before_action :set_cache_buster, only: [:new, :index, :completepost]

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to completepost_items_path
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def completepost
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to completepost_items_path
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to item_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price)
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
