class MemosController < ApplicationController
  before_action :set_memo, only: [:destroy]
  before_action :set_item, only: [:create, :destroy]

  def create
    @memo = @item.memos.new(memo_params)
    @memo.user = current_user
    if @memo.save
      redirect_to item_path(@item)
    else
      @memos = @item.memos.order("created_at DESC")
      render 'items/show', status: :unprocessable_entity
    end
  end

  def destroy
    if @memo.user == current_user
      @memo.destroy
      redirect_to item_path(@item), notice: 'Memo was successfully deleted.'
    else
      redirect_to item_path(@item), alert: 'You are not authorized to delete this memo.'
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:content, :title_id)
  end

  def set_memo
    @memo = Memo.find(params[:id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
