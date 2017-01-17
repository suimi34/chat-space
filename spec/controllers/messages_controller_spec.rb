require 'rails_helper'
require 'faker'
require 'messages_controller'

describe MessagesController do
  describe "GET #index" do
    it "populates an array of messages" do
      messages = create_list(:message, 5, chat_group_id: 1)
      get :index, params: { id: 1 }
      expect(assigns(:messages)).to match_array(messages)
    end

    it "renders the :index template" do
      chat_group = create(:chat_group)
      get :index, params: { id: chat_group.id }, use_routes: chat_group_messages_path(@message)
      expect(response).to render_template :index
    end
  end
end
