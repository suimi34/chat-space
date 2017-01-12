class MessagesController < ApplicationController
  def index
    @chat_group = ChatGroup.find(params[:id])
  end
end
