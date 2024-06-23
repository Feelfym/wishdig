class MemosController < ApplicationController
  before_action :set_memo, only: [:destroy]
  before_action :set_item, only: [:create, :destroy]

  def create
    @memo = @item.memos.build(memo_params)
    if @memo.save
      redirect_to item_path(@item)
    else
      @memos = @item.memos.order("created_at DESC")
      render 'items/show', status: :unprocessable_entity
    end
  end

  def destroy
      @memo.destroy
      redirect_to item_path(@item)
  end
  private

  def memo_params
    params.require(:memo).permit(:title_id, :content)
  end

  def set_memo
    @memo = Memo.find(params[:id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
