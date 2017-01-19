require 'rails_helper'
require 'faker'
require 'messages_controller'

describe MessagesController, type: :controller do
  describe "GET #index" do
    let(:user) { FactoryGirl.build(:user) }
    before do
      user = create(:user)
      sign_in user
    end

    it "populates an array of messages" do
      chat_group = create(:chat_group)
      messages = create_list(:message, 5, chat_group_id: chat_group.id)
      get :index, params: { chat_group_id: chat_group }, use_routes: chat_group_messages_path(chat_group)
      expect(assigns(:messages)).to match_array(messages)
    end

    it "renders the :index template" do
      chat_group = create(:chat_group)
      get :index, params: { chat_group_id: chat_group }, use_routes: chat_group_messages_path(chat_group)
      expect(response).to render_template :index
    end

    it "populates a variable of message" do
      chat_group = create(:chat_group)
      message = create(:message)
      get :index, params: { chat_group_id: chat_group }, use_routes: chat_group_messages_path(chat_group)
      expect(assigns(:message)).to be_a_new(Message)
    end

    it "populates a variable of chat_group" do
      chat_group = create(:chat_group)
      get :index, params: { chat_group_id: chat_group }, use_routes: chat_group_messages_path(chat_group)
      expect(assigns(:chat_group)).to eq chat_group
    end
  end
end
