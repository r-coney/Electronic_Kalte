require 'rails_helper'

RSpec.describe "Kaltes", type: :request do
  let!(:test_kalte) { FactoryBot.create(:kalte) }
  describe "#new" do
    it "カルテ作成ページの表示に成功する" do
      get new_kalte_path
      expect(response).to have_http_status(200)
    end
  end

  describe "#create" do
    context "有効な情報の場合" do
      it "カルテ作成に成功する" do
        expect{ post kaltes_path, params: { kalte: { menu: 'cut', request: '短くしたい', menu_description: 'カルテ作成のテスト', note: 'カルテ作成テストのメモ' } } }.to change { Kalte.count }.by(1)
      end
    end

    context "無効な情報の場合" do
      it "カルテ作成に失敗する" do
        expect{ post kaltes_path, params: { kalte: { menu: ' ' } } }.to change { Kalte.count }.by(0)
        expect(response.body).to include 'メニューを入力してください'
      end
    end
  end

  describe "#show" do
    it 'カルテ詳細ページの表示に成功する' do
      get kalte_path(test_kalte)
      expect(response).to have_http_status(200)
    end
  end

  describe "#edit" do
    it 'カルテ編集画面の表示に成功する' do
      get edit_kalte_path(test_kalte)
      expect(response).to have_http_status(200)
    end
  end

  describe "#update" do
    context '有効なカルテ情報の場合' do
      it 'カルテ情報の編集に成功する' do
        patch kalte_path(test_kalte), params: { kalte: { menu: 'カルテの更新', request: '更新のテストをしたい', menu_description: 'カルテ編集のテスト', note: 'カルテの編集が正常にできる' } }
        expect(test_kalte.reload.menu).to eq 'カルテの更新'
      end
    end

    context '無効なカルテ情報の場合' do
      it 'カルテ情報の編集に失敗する' do
        patch kalte_path(test_kalte), params: { kalte: { menu: ' ' } }
        expect(response.body).to include 'メニューを入力してください'
      end
    end
  end

  describe '#destroy' do
    it 'カルテが削除される' do
      expect{ delete kalte_path(test_kalte) }.to change{ Kalte.count }.by(-1)
    end
  end
end
