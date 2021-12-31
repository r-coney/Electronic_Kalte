require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe "ユーザー管理機能" do
    let!(:test_user) { FactoryBot.create(:user)}
    describe "一覧表示機能" do
      before { visit users_path }
      it "登録されたスタッフが表示される" do
        expect(page).to have_content test_user.name
        expect(page).to have_content test_user.phone
        expect(page).to have_content test_user.email
      end
    end

    describe "ユーザーを登録する" do 
      before do
        visit new_user_path 
        fill_in "氏名", with: test_name
        fill_in "電話番号", with: "00000000000"
        fill_in "Eメール", with: "test_user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認用）", with: "password"
        click_button "登録する"
      end
      context "有効なユーザー情報の場合" do
        let(:test_name) { "test_user" }
        it "正常に登録される" do
          expect(page).to have_selector ".alert-success", text: "#{test_name}を登録しました"
        end
      end

      context "無効なユーザー情報の場合" do
        let(:test_name) { " " }
        it "登録に失敗し、登録画面に戻る" do
          within '#error_explanation' do
            expect(page).to have_content '氏名を入力してください'
          end
          expect(page).to have_selector 'h1', text: "スタッフ登録"
        end
      end
    end
  end
end
