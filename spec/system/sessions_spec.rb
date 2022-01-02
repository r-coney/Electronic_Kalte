require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  describe "ログイン機能" do
    let!(:test_user) { FactoryBot.create(:user) }

    describe "ログイン" do
      before do
        visit login_path
        fill_in "Eメール", with: test_user.email
        fill_in "パスワード", with: test_user_password
        click_button "ログインする"
      end
      context "有効なユーザー情報の場合" do
        describe "ログイン" do
          let(:test_user_password) { test_user.password }
          it "ログインに成功する" do
            expect(page).to have_selector '.alert-success', text: "ログインしました"
          end
        end
      end
    
      context "無効なユーザー情報の場合" do
        let(:test_user_password) { " "}
        it "ログインに失敗し、ログイン画面にもどる" do
          expect(page).to have_content "Eメールまたはパスワードが正しくありません"
          expect(page).to have_selector 'h1', text: "ログイン"
        end
      end
    end

    describe "ログアウト" do
      before do
        visit user_path(test_user)
        click_link "ログアウト"
      end
      it "ログアウトして、ログイン画面を表示する" do
        expect(page).to have_selector ".alert-success", text: "ログアウトしました"
        expect(page).to have_selector "h1", text: "ログイン"
      end
    end
  end
end
