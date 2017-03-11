class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.text :content
      t.integer :transmittion_user_id
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
