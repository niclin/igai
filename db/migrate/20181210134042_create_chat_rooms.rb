class CreateChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|
      t.integer :product_id
      t.integer :sender_id
      t.integer :receiver_id

      t.timestamps
    end
  end
end
