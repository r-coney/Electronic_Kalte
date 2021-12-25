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

  # describe "#edit" do

end
