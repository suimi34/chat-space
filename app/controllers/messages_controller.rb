class MessagesController < ApplicationController

  def index
    @chat_group = ChatGroup.find(params[:chat_group_id])
  end
end
