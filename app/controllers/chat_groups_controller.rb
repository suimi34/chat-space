class ChatGroupsController < ApplicationController
  def index
  end

  def new
    @chat_group = ChatGroup.new
  end

  def create
  end
end
