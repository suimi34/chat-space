require 'rails_helper'
require 'faker'
require 'messages_controller'

describe MessagesController, type: :controller do
  describe "GET #index" do
    let(:user) { FactoryGirl.build(:user) }
    before do
      @user = create(:user)
      sign_in @user
    end

    it "populates an array of messages" do
      messages = create_list(:message, 5, chat_group_id: 1)
      get :index, params: { id: 1 }
      expect(assigns(:messages)).to match_array(messages)
    end

    it "renders the :index template" do
      chat_group = create(:chat_group)
      chat_groups = create_list(:chat_group, 5)
      message = create(:message, chat_group_id: chat_group.id)
      messages = create_list(:message, 5, chat_group_id: chat_group.id)
      binding.pry
      get :index, params: { chat_group_id: chat_group }, use_routes: chat_group_messages_path(chat_group)
      expect(response).to render_template :index
    end
  end
end
