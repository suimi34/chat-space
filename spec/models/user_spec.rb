require 'rails_helper'

describe User do
  describe '#create' do

    it "is invalid without a name" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("ユーザー名は空ではいけません")
    end
  end

  it "is invalid without an email" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("メールアドレスが空です")
  end
end
