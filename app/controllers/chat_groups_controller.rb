class ChatGroupsController < ApplicationController

  def index
  end

  def new
    @chat_group = ChatGroup.new
  end

  def create
    binding.pry
    @chat_group = ChatGroup.create(name: params[:chat_group][:name])
    redirect_to controller: :messages, action: :index, chat_group_id: @chat_group.id
  end

  def edit
    @chat_group = ChatGroup.find(params[:id])
  end

  def update
  end
end
