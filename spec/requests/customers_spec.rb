require 'rails_helper'

RSpec.describe "Customers", type: :request do
  let!(:test_customer) { FactoryBot.create(:customer)}
  describe "#index" do
    it '顧客一覧画面の表示に成功する' do
      get customers_path
      expect(response).to have_http_status(200)
    end
  end

  describe "#new" do
    it '顧客登録画面の表示に成功する' do
      get new_customer_path
      expect(response).to have_http_status(200)
    end
  end

  describe "#create" do
    context "有効な顧客情報の場合" do
      it '顧客登録に成功する' do
        expect{ post customers_path, params: { customer: { name: 'customer', birthday: '2021-12-21', address: '滋賀', phone: '00000000000', gender: :man } } }.to change{ Customer.count }.by(1)
      end
    end

    context "無効な顧客情報の場合" do
      it '顧客登録に失敗する' do
        expect{ post customers_path, params: { customer: { name: ' ' } } }.to change{ Customer.count }.by(0)
        expect(response.body).to include '氏名を入力してください'
      end
    end
  end
  
  describe "#show" do
    it '顧客詳細画面の表示に成功する' do
      get customer_path(test_customer)
      expect(response).to have_http_status(200)
    end
  end
  
  describe "#edit" do
    it '顧客情報編集画面の表示に成功する' do
      get edit_customer_path(test_customer)
      expect(response).to have_http_status(200)
    end
  end
  
  describe "#update" do
    context '有効な顧客情報の場合' do
      it '顧客情報の編集に成功する' do
        patch customer_path(test_customer), params: { customer: { name: 'テスト顧客2', birthday: '2021-12-21', address: '滋賀', phone: '00000000000', gender: :man } }
        expect(test_customer.reload.name).to eq 'テスト顧客2'
      end
    end
    
    context '無効な顧客情報の場合' do
      it '顧客情報の編集に失敗する' do
        patch customer_path(test_customer), params: { customer: { name: ' ' } }
        expect(response.body).to include '氏名を入力してください'
      end
    end
  end
end
