require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:chat_group) { create(:chat_group) }

  before do
    sign_in user
  end

  describe "GET #index" do

    it "renders the :index template" do
      get :index, params: { chat_group_id: chat_group }
      expect(response).to render_template :index
    end

    it "populates an array of messages" do
      messages = create_list(:message, 5, chat_group_id: chat_group.id)
      get :index, params: { chat_group_id: chat_group }
      expect(assigns(:messages)).to match_array(messages)
    end

    it "populates a variable of message" do
      message = build(:message)
      get :index, params: { chat_group_id: chat_group }
      expect(assigns(:message)).to be_a_new(Message)
    end

    it "populates a variable of chat_group" do
      get :index, params: { chat_group_id: chat_group }
      expect(assigns(:chat_group)).to eq chat_group
    end

    it "populates an array of users" do
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

    it "creates new message in database" do
      message = build(:message, chat_group_id: chat_group.id, user_id: user.id)
      post :create,  params: {chat_group_id: chat_group.id, message: { body: message.body } }
      change(Message, :count).by(1)
    end

    it "redirects to chat_group_messages_path" do
      message = build(:message, chat_group_id: chat_group.id, user_id: user.id)
      post :create,  params: {chat_group_id: chat_group.id, message: { body: message.body } }
      expect(response).to redirect_to chat_group_messages_path(chat_group)
    end

    it "fails to save if input is invalid" do
      message = build(:message, :as_invalid_input)
      post :create,  params: {chat_group_id: chat_group.id, message: { body: message.body } }
      expect(flash[:alert]).to eq("メッセージが入力されていません。")
      expect(response).to redirect_to chat_group_messages_path(chat_group)
    end
  end
end
