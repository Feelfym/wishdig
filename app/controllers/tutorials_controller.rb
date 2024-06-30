class TutorialsController < ApplicationController
  before_action :initialize_session, only: [:step1, :step2, :step3, :update_step1, :update_step2, :update_step3]

  def step1
    @item = Item.new(session[:item_params])
  end

  def step2
    @item = Item.new(session[:item_params])
  end

  def step3
    @item = Item.new(session[:item_params])
  end

  def update_step1
    @item = Item.new(session[:item_params].merge(item_params_step1))
    if @item.name.present?
      session[:item_params] = session[:item_params].merge(item_params_step1)
      redirect_to step2_tutorial_path
    else
      @item.errors.add(:name, "空欄にはできません") if @item.name.blank?
      render :step1, status: :unprocessable_entity
    end
  end

  def update_step2
    @item = Item.new(session[:item_params].merge(item_params_step2))
    if @item.description.present?
      session[:item_params] = session[:item_params].merge(item_params_step2)
      redirect_to step3_tutorial_path
    else
      @item.errors.add(:description, "空欄にはできません") if @item.description.blank?
      render :step2, status: :unprocessable_entity
    end
  end

  def update_step3
    session[:item_params] = session[:item_params].merge(item_params)
    @item = Item.new(session[:item_params])

    if @item.save
      @user = current_user
      session[:item_params] = nil
      @user.update_attribute(:first_sign_in, false)
      redirect_to @item
    else
      render :step3, status: :unprocessable_entity
    end
  end

  private

  def initialize_session
    session[:item_params] ||= {}
  end

  def item_params_step1
    params.require(:item).permit(:name).merge(user_id: current_user.id)
  end

  def item_params_step2
    params.require(:item).permit(:description).merge(user_id: current_user.id)
  end

  def item_params_step3
    params.require(:item).permit(:price, :will_purchase_date, :url, :purchased_flag, :purchased_date, :image, :comparison_id).merge(user_id: current_user.id)
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :will_purchase_date, :url, :purchased_flag, :purchased_date, :image, :comparison_id).merge(user_id: current_user.id)
  end
end
