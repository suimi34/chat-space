require 'rails_helper'
require 'faker'
require 'messages_controller'

describe MessagesController do
  describe "GET #index" do
    it "populates an array of messages" do
      messages = create_list(:message, 3)
      get :index, params: { id: 1 }, use_routes: :chat_group_messages
      expect(assigns(:messages)).to match_array(messages)
    end

    it "renders the :index template" do
      get :index, params: { id: 1 }
      expect(response).to render_template :index
    end
  end
end
