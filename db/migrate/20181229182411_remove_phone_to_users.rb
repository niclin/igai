class RemovePhoneToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :phone
  end
end
