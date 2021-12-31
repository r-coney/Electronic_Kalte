require 'rails_helper'

RSpec.describe "Users", type: :request do
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
  
    # describe "GET /edit" do
    #   it "returns http success" do
    #     get "/users/edit"
    #     expect(response).to have_http_status(:success)
    #   end
    # end
  
    # describe "GET /show" do
    #   it "returns http success" do
    #     get "/users/show"
    #     expect(response).to have_http_status(:success)
    #   end
    # end

end
