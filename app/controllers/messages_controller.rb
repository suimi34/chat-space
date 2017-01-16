class MessagesController < ApplicationController

  before_action :set_chat_group_info

  def index
    @chat_groups = current_user.chat_groups
    @message = Message.new
  end

  def create
    @message = Message.create(body: message_params[:body], chat_group_id: @chat_group.id, user_id: current_user.id)
  end

  private
  def message_params
    params.require(:message).permit(:body)
  end

  def set_chat_group_info
    @chat_group = ChatGroup.find(params[:chat_group_id])
    @users = @chat_group.users
  end
end
