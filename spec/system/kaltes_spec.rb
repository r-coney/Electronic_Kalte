require 'rails_helper'

RSpec.describe "カルテ管理機能", type: :system do
  let!(:test_customer) { FactoryBot.create(:customer)}
  let!(:test_kalte) { FactoryBot.create(:kalte, customer_id: test_customer.id) }
  describe "カルテを作成する" do
    before do
      visit new_customer_kalte_path(test_customer)
      fill_in 'メニュー', with: kalte_menu
      fill_in '要望', with: "明るくしたい"
      fill_in '施術内容', with: "カルテ作成のテストをする"
      fill_in 'メモ', with: "カルテ作成テストのメモ"
      click_button '登録する'
    end

    context "有効なカルテ情報を入力した場合" do
      let(:kalte_menu) { 'color' }
      it '正常に作成される' do
        expect(page).to have_selector '.alert-success', text: "カルテを作成しました"
      end
    end

    context "無効なカルテ情報の場合" do
      let(:kalte_menu) { ' ' }
      it 'カルテ作成に失敗し、カルテ作成画面にもどる' do
        within '#error_explanation' do
          expect(page).to have_content 'メニューを入力してください'
        end
        expect(page).to have_selector 'h1', text: "カルテ作成"
      end
    end
  end

  describe "カルテ詳細表示機能機能" do
    before { visit customer_kalte_path(test_customer, test_kalte) }
    it 'カルテ詳細情報が表示される' do
      expect(page).to have_content test_kalte.menu
      expect(page).to have_content test_kalte.request
      expect(page).to have_content test_kalte.menu_description
      expect(page).to have_content test_kalte.note
    end
  end

  describe "カルテ情報編集機能" do
    before do
      visit edit_customer_kalte_path(test_customer, test_kalte)
      fill_in 'メニュー', with: kalte_menu
      fill_in '要望', with: "明るくしたい"
      fill_in '施術内容', with: "カルテ作成のテストをする"
      fill_in 'メモ', with: "カルテ作成テストのメモ"
      click_button '更新する'
    end

    context '有効なカルテ情報の場合' do
      let(:kalte_menu) { 'cut&color' }
      it '正常に更新できる' do
        expect(page).to have_selector '.alert-success', text: "カルテを更新しました"
      end
    end

    context '無効なカルテ情報の場合' do
      let(:kalte_menu) { ' ' }
      it 'カルテ情報の更新に失敗し、更新画面に戻る' do 
        expect(page).to have_selector 'h1', text: "カルテ情報編集"
      end
    end
  end

  describe "カルテ削除機能" do
    before do
       visit customer_path(test_customer) 
       click_link '削除'
    end
    it 'カルテを削除する' do
      expect(page.accept_confirm).to eq "カルテを削除します。よろしいですか？"
      expect(page).to have_selector '.alert-success', text: "カルテを削除しました"
    end
  end
end