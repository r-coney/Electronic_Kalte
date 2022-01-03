require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:test_customer) { FactoryBot.create(:customer)}
  context '顧客情報が有効な場合' do
    it '顧客情報が有効である' do
      expect(test_customer).to be_valid
    end
  end

  context '顧客情報が無効な場合' do
    describe '氏名' do
      it '氏名ない場合、無効である' do
        test_customer.name = ' '
        expect(test_customer).not_to be_valid
      end
  
      it '氏名が50文字を超える場合、無効である' do
        test_customer.name = 'a' * 51
        expect(test_customer).not_to be_valid
      end
    end

    describe '生年月日' do
      it '生年月日がない場合、無効である' do
        test_customer.birthday = ' '
        expect(test_customer).not_to be_valid
      end

      it '生年月日が20文字をこえる場合、無効である' do
        test_customer.birthday = ' '
        expect(test_customer).not_to be_valid
      end
    end

    describe '住所' do
      it '住所がない場合、無効である' do
        test_customer.address = ' '
        expect(test_customer).not_to be_valid
      end
       
      it '住所が50文字を超える場合、無効である' do
        test_customer.address = 'a' * 51
        expect(test_customer).not_to be_valid
      end
    end

    describe '電話番号' do
      it '電話番号がない場合、無効である' do
        test_customer.phone = ' '
        expect(test_customer).not_to be_valid
      end
      
      it '電話番号が15文字をこえる場合、無効である' do
        test_customer.phone = '0' * 16
        expect(test_customer).not_to be_valid
      end
    end

    describe '性別' do
      it '性別がない場合、無効である' do
        test_customer.gender = ' '
        expect(test_customer).not_to be_valid
      end
    end
  end
end
