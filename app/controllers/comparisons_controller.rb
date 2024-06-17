class ComparisonsController < ApplicationController
  berore_action :set_comparison, only: [:show, :destroy]

  def index
    @comparisons = Comparison.all
  end

  def show
    @note = @comparison.notes.build
  end

  def new
    @comparison = Comparison.new
    user_items_not_purchased
  end

  def create
    existing_comparison = find_existing_comparison
    if existing_comparison
      redirect_to comparison_path(existing_comparison)
    else
      @comparison = Comparison.new(comparison_params)
      if @comparison.save
        redirect_to @comparison
      else
        user_items_not_purchased
        render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @comparison.destroy
    redirect_to comparisons_path
  end

  private

  def comparison_params
    params.require(:comparison).permit(:primary_item_id, :secondary_item_id, notes_attributes: [:attribute_name, :primary_value, :secondary_value])
  end

  def user_items_not_purchased
    @items = Item.not_purchased.where(user_id: current_user.id)
  end

  def find_existing_comparison
    Comparison.find_by(primary_item_id: comparison_params[:primary_item_id], secondary_item_id: comparison_params[:secondary_item_id]) ||
    Comparison.find_by(primary_item_id: comparison_params[:secondary_item_id], secondary_item_id: comparison_params[:primary_item_id])
  end

  def set_comparison
    @comparison = Comparison.find(params[:id])
  end

end
