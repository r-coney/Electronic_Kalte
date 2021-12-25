require 'rails_helper'

RSpec.describe "KaltesSpec.rbs", type: :system do
  describe "カルテを作成する" do
    before do
      visit new_kalte_path
      fill_in 'メニュー', with: kalte_menu
      fill_in '要望', with: "明るくしたい"
      fill_in '施術内容', with: "カルテ作成のテストをする"
      fill_in 'メモ', with: "カルテ作成テストのメモ"
      click_button '登録する'
    end

    context "有効なカルテ情報を入力した場合" do
      let(:kalte_menu) { 'color' }
      it '正常に作成される' do
        expect(page).to have_selector '.alert-success', text: "カルテを作成しました。"
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
end
