class CreateCategorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :categorizations do |t|
      t.integer :product_id
      t.integer :category_id

      t.timestamps
    end

    add_index :categorizations, [:product_id, :category_id]
  end
end
