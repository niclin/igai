class AddAasmStateToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :aasm_state, :string
  end
end
