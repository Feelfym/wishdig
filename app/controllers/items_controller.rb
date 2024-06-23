class ItemsController < ApplicationController
  before_action :set_selected_year_and_month
  before_action :set_item, only: %i[edit update destroy purchase]
  before_action :set_user, only: %i[index purchased]

  def index
    @items = filter_items(@user.items.not_purchased)
    @total = @items.total_price
  end

  def show
    @memo = Memo.new
    @memos = Memo.where(item_id: params[:id]).order("created_at DESC")
    if user_signed_in? && current_user.id == Item.find(params[:id]).user_id
      set_item
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
  end

  def update
    comparison_id = params[:comparison_id]

    if @item.update(item_params)
      if params[:source] == 'comparison'
        redirect_to comparison_path(comparison_id)
      elsif params[:source] == 'index'
        redirect_to items_path
      elsif params[:source] == 'show'
        redirect_to item_path(@item)
      elsif params[:source] == 'purchased'
        redirect_to purchased_items_path
      else
        redirect_to items_path
      end
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  def purchase
    if @item.purchased_flag
      @item.update(purchased_flag: false, purchased_date: nil)
    else
      @item.update(purchased_flag: true, purchased_date: Time.now)
    end
    redirect_to items_path
  end

  def purchased
    @items = filter_items(Item.where(purchased_flag: true))
    @total = @items.total_price
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :will_purchase_date, :url, :purchased_flag, :purchased_date, :image, :comparison_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def set_selected_year_and_month
    @selected_year = params[:selected_year].present? ? params[:selected_year].to_i : nil
    @selected_month = params[:selected_month].present? ? params[:selected_month].to_i : nil
  end

  def filter_items(items)
    if @selected_year.present? && @selected_month.present?
      items.for_year_and_month(@selected_year, @selected_month)
    else
      items
    end
  end
end
