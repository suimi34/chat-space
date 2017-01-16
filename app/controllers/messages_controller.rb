class MessagesController < ApplicationController

  def index
    @chat_group = ChatGroup.find(params[:chat_group_id])
    @chat_groups = current_user.chat_groups
    @users = @chat_group.users
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to chat_group_messages_path(@chat_group)
    else
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(body: params[:body], chat_group_id: params[:chat_group_id], user_id: params[:user_id])
  end
end
