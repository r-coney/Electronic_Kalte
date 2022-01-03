require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:test_user) { FactoryBot.create(:user) }
  before { log_in_as(test_user) }

  describe "#index" do
    it "ユーザー一覧ページの表示に成功する" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "#new" do
    it "ユーザー登録ページの表示に成功する" do
      get new_user_path
      expect(response).to have_http_status(200)
    end
  end

  describe "#create" do
    context '有効なユーザー情報の場合' do
      it 'ユーザーの登録に成功する' do
        expect{ post users_path, params: { user: { name: "test", phone: "00000000000", email: "test@example.com", password: "password", password_confirmation: "password" } } }.to change{ User.count }.by(1)
      end
    end

    context '無効なユーザー情報の場合' do
      it 'ユーザーの登録に失敗する' do
        expect{ post users_path, params: { user: { name: " "} } }.to change{ User.count }.by(0)
      end
    end
  end

  describe "#show" do
    it "ユーザー詳細ページの表示に成功する" do
      get user_path(test_user)
      expect(response).to have_http_status(200)
    end
  end
  

  describe "#edit" do
    it "ユーザー情報編集ページの表示に成功する" do
      get edit_user_path(test_user)
      expect(response).to have_http_status(200)
    end
  end
  
  describe "#update" do
    context "有効なユーザー情報の場合" do
      it "ユーザー情報の更新に成功する" do
        patch user_path(test_user),params: { user: {  name: "test", phone: "00000000000", email: "test@example.com", password: "password", password_confirmation: "password"} }
        expect(test_user.reload.name).to eq "test"
      end
    end

    context "無効なユーザー情報の場合" do
      it "ユーザー情報の更新に失敗する" do
        patch user_path(test_user),params: { user: {  name: " " } }
        expect(response.body).to include "氏名を入力してください"
      end
    end
  end

  describe "#destroy" do
    it "ユーザーが消去される" do
      expect{ delete user_path(test_user) }.to change{ User.count }.by(-1)
    end
  end
end
