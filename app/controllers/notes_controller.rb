class NotesController < ApplicationController
  def create
    @comparison = Comparison.find(params[:comparison_id])
    @note = @comparison.notes.build(note_params)
    if @note.save
      redirect_to @comparison, notice: 'Note was successfully created.'
    else
      render 'comparisons/show'
    end
  end

  def destroy
    @comparison = Comparison.find(params[:comparison_id])
    @note = @comparison.notes.find(params[:id])
    @note.destroy
    redirect_to @comparison, notice: 'Note was successfully deleted.'
  end

  private

  def note_params
    params.require(:note).permit(:attribute_name, :primary_value, :secondary_value)
  end
end
