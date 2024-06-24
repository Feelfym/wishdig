class AddUserIdToComparison < ActiveRecord::Migration[7.0]
  def change
    add_column :comparisons, :user_id, :integer
  end
end
