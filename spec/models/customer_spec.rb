require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { FactoryBot.create(:customer)}
  context '顧客情報が有効な場合' do
    it '顧客情報が有効である' do
      expect(customer).to be_valid
    end
  end

  context '顧客情報が無効な場合' do
    describe '氏名' do
      it '氏名ない場合、無効である' do
        customer.name = ' '
        expect(customer).not_to be_valid
      end
  
      it '氏名が50文字を超える場合、無効である' do
        customer.name = 'a' * 51
        expect(customer).not_to be_valid
      end
    end

    describe '生年月日' do
      it '生年月日がない場合、無効である' do
        customer.birthday = ' '
        expect(customer).not_to be_valid
      end

      it '生年月日が20文字をこえる場合、無効である' do
        customer.birthday = ' '
        expect(customer).not_to be_valid
      end
    end

    describe '住所' do
      it '住所がない場合、無効である' do
        customer.address = ' '
        expect(customer).not_to be_valid
      end
       
      it '住所が50文字を超える場合、無効である' do
        customer.address = 'a' * 51
        expect(customer).not_to be_valid
      end
    end

    describe '電話番号' do
      it '電話番号がない場合、無効である' do
        customer.phone = ' '
        expect(customer).not_to be_valid
      end
      
      it '電話番号が15文字をこえる場合、無効である' do
        customer.phone = '0' * 16
        expect(customer).not_to be_valid
      end
    end

    describe '性別' do
      it '性別がない場合、無効である' do
        customer.gender = ' '
        expect(customer).not_to be_valid
      end
    end
  end
end
