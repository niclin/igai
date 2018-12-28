class AddInfosToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :phone, :string
    add_column :users, :facebook_url, :string
    add_column :users, :line_url, :string
    add_column :users, :shopee_url, :string
  end
end
