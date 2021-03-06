require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe "ユーザー管理機能" do
    let!(:test_user) { FactoryBot.create(:user) }
    describe "一覧表示機能" do
      let!(:test_user2) { FactoryBot.create(:user, phone: "02000000000") }
      before do
        sign_in(test_user)
        visit users_path
      end 
      it "登録されたスタッフが表示される" do
        expect(page).to have_content test_user.name
        expect(page).to have_content test_user.phone
      end

      it "氏名から検索したスタッフ以外は表示されていない" do
        fill_in "氏名", with: test_user.name
        click_button "検索"
        expect(page).to_not have_content test_user2.name
        expect(page).to_not have_content test_user2.phone
        expect(page).to_not have_content test_user2.email
      end

      it "電話番号から検索したスタッフ以外は表示されていない" do
        fill_in "電話番号", with: test_user.phone
        click_button "検索"
        expect(page).to_not have_content test_user2.name
        expect(page).to_not have_content test_user2.phone
        expect(page).to_not have_content test_user2.email
      end
    end

    describe "ユーザーを登録する" do 
      before do
        sign_in(test_user)
        visit new_user_path 
        fill_in "氏名", with: test_name
        fill_in "電話番号", with: "00000000000"
        fill_in "Eメール", with: "test@example.com"
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

    describe "ユーザー詳細表示機能" do
      before do
        sign_in(test_user)
        visit user_path(test_user)
      end 
      it "ユーザー詳細情報が表示される" do
        expect(page).to have_content test_user.name
        expect(page).to have_content test_user.phone
        expect(page).to have_content test_user.email
      end
    end

    describe "ユーザー情報編集機能" do
      before do
        sign_in(test_user)
        visit edit_user_path(test_user)
        fill_in "氏名", with: test_name
        fill_in "電話番号", with: "00000000000"
        fill_in "Eメール", with: "test@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認用）", with: "password"
        click_button '更新する'
      end
      context "有効なユーザー情報の場合" do
        let(:test_name) { "更新のテスト"}
        it "正常に更新できる" do
          expect(page).to have_selector ".alert-success", text: "スタッフ情報を更新しました"
        end
      end

      context "無効なユーザー情報の場合" do
        let(:test_name) { " " }
        it "ユーザー情報の更新に失敗し、更新画面に戻る" do
          expect(page).to have_selector "h1", text: "スタッフ情報編集"
        end
      end
    end

    describe "ユーザー削除機能" do
      before do
        sign_in(test_user)
        visit user_path(test_user)
        click_link "削除"
      end
      it "ユーザーが削除される" do
        expect(page.accept_confirm).to eq "#{test_user.name}を削除します。よろしいですか？"
        expect(page).to have_selector '.alert-success', text: "#{test_user.name}を削除しました"
      end
    end

    describe "管理者権限" do
      let!(:not_admin_user) { FactoryBot.create(:user, admin: false) }
      before{ sign_in(not_admin_user) }
      it "管理者以外はスタッフ一覧画面の表示に失敗し、顧客一覧画面が表示される" do
        visit users_path
        expect(current_path).to eq root_path
      end

      it "管理者以外はスタッフ登録画面の表示に失敗し、顧客一覧画面が表示される" do
        visit new_user_path
        expect(current_path).to eq root_path
      end

      it "管理者以外はスタッフ情報編集画面の表示に失敗し、顧客一覧画面が表示される" do
        visit edit_user_path(not_admin_user)
        expect(current_path).to eq root_path
      end
    end
  end
end
