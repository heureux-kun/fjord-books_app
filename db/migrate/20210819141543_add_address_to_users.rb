class AddAddressToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :zip, :string
    add_column :users, :address, :text
    add_column :users, :profile, :text
  end
end
