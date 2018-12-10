class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :chat_room_id
      t.text :context
      t.datetime :read_at

      t.timestamps
    end
  end
end
