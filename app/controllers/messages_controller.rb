class MessagesController < ApplicationController

  def index
    @chat_group = ChatGroup.find(params[:chat_group_id])
    group_user_ids = current_user.chat_group_ids
    @chat_groups = group_user_ids.map{ |id| ChatGroup.find(id) }
  end
end
