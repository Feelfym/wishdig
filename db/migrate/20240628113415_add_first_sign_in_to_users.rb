class AddFirstSignInToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_sign_in, :boolean, default: true, null: false
  end
end
