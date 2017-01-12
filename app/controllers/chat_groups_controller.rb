class ChatGroupsController < ApplicationController

  def index
  end

  def new
    @chat_group = ChatGroup.new
  end

  def create
    @chat_group = ChatGroup.new(name: params[:chat_group][:name], user_ids: current_user.id)
    if @chat_group.save
      redirect_to chat_group_messages_path(@chat_group), chat_group_id: @chat_group.id
    else
      new_chat_group_path(@chat_group)
    end
  end

  def edit
    @chat_group = ChatGroup.find(params[:id])
  end

  def update
  end
end
