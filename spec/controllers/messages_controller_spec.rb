require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:chat_group) { create(:chat_group) }

  before do
    sign_in user
  end

  describe "GET #index" do

    it "renders the :index template" do
      chat_group
      get :index, params: { chat_group_id: chat_group }
      expect(response).to render_template :index
    end

    it "populates an array of messages" do
      chat_group
      messages = create_list(:message, 5, chat_group_id: chat_group.id)
      get :index, params: { chat_group_id: chat_group }
      expect(assigns(:messages)).to match_array(messages)
    end

    it "populates a variable of message" do
      chat_group
      message = build(:message)
      get :index, params: { chat_group_id: chat_group }
      expect(assigns(:message)).to be_a_new(Message)
    end

    it "populates a variable of chat_group" do
      chat_group
      get :index, params: { chat_group_id: chat_group }
      expect(assigns(:chat_group)).to eq chat_group
    end

    it "populates an array of users" do
      chat_group
      users = chat_group.users
      get :index, params: { chat_group_id: chat_group }
      expect(assigns(:users)).to match_array(users)
    end

    it "populates an array of chat_groups" do
      chat_groups = user.chat_groups
      get :index, params: { chat_group_id: chat_group }
      expect(assigns(:chat_groups)).to match_array(chat_groups)
    end
  end

  describe "POST #create" do

    it "renders the :create template after message saves" do
      chat_group
      message = attributes_for(:message, chat_group_id: chat_group, user_id: user)
      binding.pry
      post :create, params: { message: { chat_group_id: chat_group } }, use_routes: chat_group_messages_path(chat_group)
      expect(response).to redirect_to chat_group_messages_path(chat_group)
    end
  end
end
