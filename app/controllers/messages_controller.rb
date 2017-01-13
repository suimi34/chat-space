class MessagesController < ApplicationController

  def index
    @chat_group = ChatGroup.find(params[:chat_group_id])
    @chat_groups = current_user.chat_groups
    @message = Message.new
  end
end
