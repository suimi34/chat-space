class MessagesController < ApplicationController

  before_action :set_chat_group_info

  def index
    @chat_groups = current_user.chat_groups
    @message = Message.new
  end

  def create
    binding.pry
    @message = Message.create(message_params)
  end

  private
  def message_params
    params.require(:message).permit(:body).merge(chat_group_id: params[:chat_group_id], user_id: current_user.id)
  end

  def set_chat_group_info
    @chat_group = ChatGroup.find(params[:chat_group_id])
    @users = @chat_group.users
  end
end
