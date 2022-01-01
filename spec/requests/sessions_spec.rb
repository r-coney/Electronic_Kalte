require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let!(:test_user) { FactoryBot.create(:user) }
  describe "#new" do
    it "ログインページの表示に成功する" do
      get login_path
      expect(response).to have_http_status(200)
    end
  end

  describe "#create" do
    context "有効なユーザー情報の場合" do
      it "ログインに成功する" do
        post login_path, params: { session: { email: test_user.email, password: test_user.password } }
        expect(session[:user_id]).to eq test_user.id
      end
    end

    context "無効なユーザー情報の場合" do
      it "ログインに失敗する" do
        post login_path, params: { session: { email: " ", password: " " } }
        expect(session[:user_id]).to eq nil
      end
    end
  end
end
