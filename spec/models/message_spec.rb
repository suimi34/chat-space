require 'rails_helper'

describe Message do
  describe '#create' do
    it "is invalid if body is empty" do
      message.valid?
      expect(message.errors).to include('メッセージが入力されていません。')
    end

    it "is valid if body has more than 1 character" do
      message.valid?
      expect(message).to be_valid
    end
  end
end
