class AddWillPurchaseDateToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :will_purchase_date, :date
  end
end
