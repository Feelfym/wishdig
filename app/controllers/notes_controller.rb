class NotesController < ApplicationController
  before_action :set_comparison, only: %i[create destroy]

  def create
    @note = @comparison.notes.build(note_params)
    if @note.save
      redirect_to @comparison, notice: 'Note was successfully created.'
    else
      render 'comparisons/show'
    end
  end

  def destroy
    @note = @comparison.notes.find(params[:id])
    @note.destroy
    redirect_to @comparison, notice: 'Note was successfully deleted.'
  end

  private

  def note_params
    params.require(:note).permit(:attribute_name, :primary_value, :secondary_value)
  end

  def set_comparison
    @comparison = Comparison.find(params[:comparison_id])
  end
end
