require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:test_customer) { FactoryBot.create(:customer)}
  context "顧客情報が有効な場合" do
    it "顧客情報が有効である" do
      expect(test_customer).to be_valid
    end
  end

  context "顧客情報が無効な場合" do
    describe "name" do
      it "nameない場合、無効である" do
        test_customer.name = " "
        expect(test_customer).not_to be_valid
      end
  
      it "nameが50文字を超える場合、無効である" do
        test_customer.name = "a" * 51
        expect(test_customer).not_to be_valid
      end
    end

    describe "birthday" do
      it "birthdayがない場合、無効である" do
        test_customer.birthday = " "
        expect(test_customer).not_to be_valid
      end

      it "日付以外のフォーマットの場合、無効である" do
        invalid_birthdays = %w[aaaa00bbcc 1111222333444 10-11-11]
        invalid_birthdays.each do |invalid_birthday|
          test_customer.phone = invalid_birthday
          expect(test_customer).not_to be_valid, "#{invalid_birthday.inspect} should be invalid"
        end
      end
    end

    describe "address" do
      it "addressがない場合、無効である" do
        test_customer.address = " "
        expect(test_customer).not_to be_valid
      end
       
      it "addressが50文字を超える場合、無効である" do
        test_customer.address = "a" * 51
        expect(test_customer).not_to be_valid
      end
    end

    describe "phone" do
      it "phoneがない場合、無効である" do
        test_customer.phone = " "
        expect(test_customer).not_to be_valid
      end
      
      it "電話番号以外のフォーマット場合、無効である" do
        invalid_phones = %w[aaabbbbcccc 0a000000000 000000000]
        invalid_phones.each do |invalid_phone|
          test_customer.phone = invalid_phone
          expect(test_customer).not_to be_valid, "#{invalid_phone.inspect} should be invalid"
        end
      end
    end

    describe "gender" do
      it "genderがない場合、無効である" do
        test_customer.gender = " "
        expect(test_customer).not_to be_valid
      end
    end
  end
end
