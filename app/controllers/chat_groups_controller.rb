class ChatGroupsController < ApplicationController

  def index
    group_user_ids = current_user.chat_group_ids
    @chat_groups = group_user_ids.map{ |id| ChatGroup.find(id) }
  end

  def new
    @chat_group = ChatGroup.new
  end

  def create
    @chat_group = ChatGroup.new(chat_group_params)
    if @chat_group.save
      redirect_to chat_group_messages_path(@chat_group), notice: 'チャットグループが作成されました。'
    else
      render :new
    end
  end

  def edit
    @chat_group = ChatGroup.find(params[:id])
  end

  def update
  end

  private
  def chat_group_params
    params.require(:chat_group).permit(:name, user_ids:[])
  end
end
