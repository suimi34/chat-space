class AddIndexToChatgroups < ActiveRecord::Migration[5.0]
  def change
    add_index :chat_groups, :name
  end
end
