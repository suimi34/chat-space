class ChatGroupsController < ApplicationController
  def index
  end

  def new
    @chat_group = ChatGroup.new
  end

  def create
    @chat_group = ChatGroup.create(name: chat_group_params[:name])
    redirect_to action: :messages, id: @chat_group.id
  end

  def messages
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
