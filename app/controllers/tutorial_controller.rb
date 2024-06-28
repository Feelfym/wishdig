class TutorialController < ApplicationController
  def index
    @item = Item.new
  end
end