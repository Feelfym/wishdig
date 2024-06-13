class ItemsController < ApplicationController
  before_action :move_to_index
  before_action :set_selected_year_and_month

  def index
    @user = current_user
    @items = @user.items.not_purchased

    @is_filtered = @selected_year.present? && @selected_month.present?
    if @is_filtered
      @items = @items.for_year_and_month(@selected_year, @selected_month)
    end

    @total = @items.sum(:price)
  end

  def clear_selected_year_and_month
    @selected_year = nil
    @selected_month = nil
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

  def purchase
    set_item
    @item.update(purchased_flag: true, purchased_date: Time.now)
    redirect_to items_path
  end

  def purchased
    @items = Item.where(purchased_flag: true)
    @user = current_user
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :will_purchase_date, :url, :purchased_flag, :purchased_date).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to new_user_session_path unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_selected_year_and_month
    if params[:year].present?
      @selected_year = params[:year].to_i
    else
      @selected_year = nil
    end

    if params[:month].present?
      @selected_month = params[:month].to_i
    else
      @selected_month = nil
    end
  end
end
