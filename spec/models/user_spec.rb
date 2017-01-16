require 'rails_helper'

describe User do
  describe '#create' do

    it "is invalid without a name" do
      user = build(:user, name: "")
      user.valid?
      expect(user.errors[:name]).to include("ユーザー名は空ではいけません")
    end

    it "is invalid without an email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("メールアドレスが空です")
    end

    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("メールアドレスが既に使用済みです")
    end

    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("パスワードが空です")
    end

    it "is invalid without password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("確認用パスワードが一致しません")
    end

    it "is invalid if password is less than 7 characters" do
      user = build(:user, password: "1234567", password_confirmation: "1234567")
      user.valid?
      expect(user.errors[:password]).to include("パスワードは8文字以上で利用できます")
    end

    it "is valid with name, email, password, and password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end
  end
end
