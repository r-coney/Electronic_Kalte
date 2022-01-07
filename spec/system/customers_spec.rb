require 'rails_helper'

describe '顧客管理機能', type: :system do
  let!(:test_user) { FactoryBot.create(:user) }
  let!(:test_customer) { FactoryBot.create(:customer) }
  before { sign_in(test_user) }
  describe "一覧表示機能" do
    let!(:test_customer2) { FactoryBot.create(:customer, phone: "02000000000") }
    before { visit customers_path }
    it '登録された顧客が表示される' do
      expect(page).to have_content test_customer.name
      expect(page).to have_content test_customer.id
      expect(page).to have_content test_customer.phone
    end

    it "氏名から検索した顧客以外は表示されていない" do
      fill_in "氏名", with: test_customer.name
      click_button "検索"
      expect(page).to_not have_content test_customer2.name
      expect(page).to_not have_content test_customer2.id
      expect(page).to_not have_content test_customer2.phone
    end

    it "電話番号から検索した顧客以外は表示されていない" do
      fill_in "電話番号", with: test_customer.phone
      click_button "検索"
      expect(page).to_not have_content test_customer2.name
      expect(page).to_not have_content test_customer2.id
      expect(page).to_not have_content test_customer2.phone
    end
  end

  describe '顧客を登録する' do
    before do
      visit new_customer_path
      fill_in '氏名', with: customer_name
      fill_in '生年月日', with: '002021-12-17'
      fill_in '住所', with: '滋賀県大津市'
      fill_in '電話番号', with: '09000000000'
      choose '男性'
      click_button '登録する'
    end
    context '有効な顧客情報を入力した場合' do
      let(:customer_name) { '新規登録のテスト顧客'}
      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: "「#{customer_name}様」を登録しました"
      end
    end

    context '無効な顧客情報を入力した場合' do
      let(:customer_name) { '' }
      it '顧客登録に失敗し、顧客登録にもどる' do
        within '#error_explanation' do
          expect(page).to have_content '氏名を入力してください'
        end
        expect(page).to have_selector 'h1', text: "顧客登録"
      end
    end
  end

  describe '顧客詳細表示機能' do 
    it '顧客詳細情報が表示される' do
      visit customer_path(test_customer)
      expect(page).to have_content test_customer.name
      expect(page).to have_content test_customer.phone
      expect(page).to have_content test_customer.birthday
      expect(page).to have_content test_customer.gender_i18n
    end
  end

  describe '顧客情報編集機能' do
    before do 
      visit edit_customer_path(test_customer) 
      fill_in '氏名', with: test_customer_name
      fill_in '生年月日', with: '002021-12-17'
      fill_in '住所', with: '滋賀県大津市'
      fill_in '電話番号', with: '09000000000'
      choose '男性'
      click_button '更新する'
    end
    context '有効な情報の場合' do
      let(:test_customer_name) { '顧客情報編集のテスト顧客' }
      it '顧客情報の更新に成功する' do
        expect(page).to have_selector '.alert-success', text: "顧客情報を更新しました"
        expect(page).to have_content '顧客情報編集のテスト顧客'
      end
    end

    context '無効な情報の場合' do
      let(:test_customer_name) { ' ' }
      it '顧客情報の更新に失敗し、顧客情報編集画面にもどる' do
        within '#error_explanation' do
          expect(page).to have_content '氏名を入力してください'
        end
        expect(page).to have_selector 'h1', text: "顧客情報編集"
      end
    end
  end
end