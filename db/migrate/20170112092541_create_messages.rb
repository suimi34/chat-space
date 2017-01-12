class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body, null: false
      t.string :image
      t.references :chat_group, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
