class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.references :comparison, null: false, foreign_key: true
      t.string :attribute_name
      t.string :primary_value
      t.string :secondary_value

      t.timestamps
    end
  end
end
