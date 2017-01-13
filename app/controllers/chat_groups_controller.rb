class ChatGroupsController < ApplicationController

  def index
  end

  def new
    @chat_group = ChatGroup.new
  end

  def create
    binding.pry
    @chat_group = ChatGroup.new(name: chat_group_params[:name], user_ids: current_user.id)
    if @chat_group.save
      redirect_to chat_group_messages_path(@chat_group), chat_group_id: @chat_group.id
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
    params.require(:chat_group).permit(:name)
  end
end
