class RemoveIndexFromChatGroups < ActiveRecord::Migration[5.0]
  def change
    remove_index :chat_groups, column: :name
  end
end
