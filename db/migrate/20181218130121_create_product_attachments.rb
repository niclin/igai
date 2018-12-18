class CreateProductAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :product_attachments do |t|
      t.integer :product_id
      t.string :image

      t.timestamps
    end
  end
end
