class ChatGroupsController < ApplicationController
  def index
  end

  def new
    @chat_group = ChatGroup.new
  end

  def create
  end

  def edit
    @chat_group = ChatGroup.find(params[:id])
  end

  def update
  end
end
