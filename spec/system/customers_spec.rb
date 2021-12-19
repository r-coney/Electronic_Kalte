require 'rails_helper'

describe '顧客管理機能', type: :system do
  let!(:customer) { FactoryBot.create(:customer)}
  describe '一覧表示機能' do
    it '登録された顧客が表示される' do
      visit customers_path
      expect(page).to have_content customer.name
      expect(page).to have_content customer.id
      expect(page).to have_content customer.phone
    end
  end

  describe '顧客を登録する' do
    before do
      visit new_customer_path
      fill_in '氏名', with: customer_name
      fill_in '生年月日', with: '2021-12-17'
      fill_in '住所', with: '滋賀県大津市'
      fill_in '電話番号', with: '000000000'
      choose '男性'
      click_button '登録する'
    end
    context '顧客登録画面で、正しい情報を入力した場合' do
      let(:customer_name) { '新規登録のテスト顧客'}
      it '正常に登録される' do
        expect(page).to have_content '新規登録のテスト顧客'
      end
    end

    # context '顧客登録画面で、間違った情報を入力した場合' do
    #   let(customer_name) { '' }
    #   it 'エラーとなる' do

    #   end
    # end
  end

  describe '顧客詳細表示機能' do 
    it '顧客詳細情報が表示される' do
      visit customer_path(customer)
      expect(page).to have_content customer.name
    end
  end
end