class ComparisonsController < ApplicationController

  def index
    @comparisons = Comparison.all
  end

  def show
    @comparison = Comparison.find(params[:id])
    @note = @comparison.notes.build
  end

  def new
    @comparison = Comparison.new
    @comparison.notes.build # Noteフィールドをビルド
  end

  def create
    @comparison = Comparison.new(comparison_params)
    if @comparison.save
      redirect_to @comparison
    else
      render :new
    end
  end

  def destroy
    @comparison = Comparison.find(params[:id])
    @comparison.destroy
    redirect_to comparisons_path
  end

  private

  def comparison_params
    params.require(:comparison).permit(:primary_item_id, :secondary_item_id, notes_attributes: [:attribute_name, :primary_value, :secondary_value])
  end
end
