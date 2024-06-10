class CreateMemos < ActiveRecord::Migration[7.0]
  def change
    create_table :memos do |t|
      t.text :content
      t.integer :user_id
      t.integer :item_id
      t.timestamps
    end
  end
end
