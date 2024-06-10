class AddPurchasedFlagToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :purchased_flag, :boolean, default: false
  end
end
