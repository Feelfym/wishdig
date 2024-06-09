class ItemsController < ApplicationController

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
      redirect_to root_path
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("item_form", partial: "items/form", locals: { item: @item }) }
      end
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
      redirect_to root_path
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
    params.require(:item).permit(:name, :description, :price, :will_purchase_date, :url)
  end

end
