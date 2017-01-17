require 'rails_helper'

describe Message do
  describe '#create' do
    it "is invalid if body is empty" do
      message = build(:message, body: "")
      message.valid?
      expect(message.errors[:body]).to include('メッセージが入力されていません。')
    end

    it "is valid if body has more than 1 character" do
      message = build(:message)
      message.valid?
      expect(message).to be_valid
    end
  end
end
