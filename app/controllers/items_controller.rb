class ItemsController < ApplicationController
  before_action :move_to_index

  def index
    @items = current_user.items
    @user = current_user
  end

  def show
    @memo = Memo.new
    @memos = Memo.where(item_id: params[:id]).order("created_at DESC")
    if user_signed_in? && current_user.id == Item.find(params[:id]).user_id
      @item = Item.find(params[:id])
    else
      redirect_to root_path
    end
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
    set_item
  end

  def completepost
  end

  def update
    set_item
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    set_item
    @item.destroy
    redirect_to item_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :will_purchase_date, :url).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to new_user_session_path unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
