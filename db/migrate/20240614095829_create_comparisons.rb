class CreateComparisons < ActiveRecord::Migration[7.0]
  def change
    create_table :comparisons do |t|
      t.integer :primary_item_id
      t.integer :secondary_item_id
      
      t.timestamps
    end
  end
end
