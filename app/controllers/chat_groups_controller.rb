class ChatGroupsController < ApplicationController
  def index
  end

  def new
    @chat_group = ChatGroup.new
  end

  def create
    ChatGroup.create(name: chat_group_params[:name])
  end

  def edit
    @chat_group = ChatGroup.find(params[:id])
  end

  def update
  end

  private
  def chat_group_params
    params.permit(:name)
  end
end
