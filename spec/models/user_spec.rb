require 'rails_helper'

RSpec.describe User, type: :model do
  let(:test_user) { FactoryBot.create(:user) }
  context "ユーザー情報が有効な場合" do
    it "ユーザー情報が有効である" do
      expect(test_user).to be_valid
    end

    it "メールアドレスは小文字で保存される" do
      mixed_case_email = "Test_User@ExamPle.Com"
      test_user.email = mixed_case_email
      test_user.save
      expect(test_user.email).to eq mixed_case_email.downcase
    end
  end

  context "ユーザー情報が無効な場合" do
    describe "name" do
      it "nameがない場合、無効である" do
        test_user.name = " "
        expect(test_user).not_to be_valid
      end

      it "nameが50文字を超える場合、無効である" do
        test_user.name = "a" * 51
        expect(test_user).not_to be_valid
      end
    end

    describe "email" do
      it "emailがない場合は、無効である" do
        test_user.email = " "
        expect(test_user).not_to be_valid
      end

      it "emailが250文字を超える場合は、無効である" do
        test_user.email = "a" * 251
        expect(test_user).not_to be_valid
      end

      it "メールアドレス以外のフォーマットの場合、無効である" do
        invalid_addresses = %w[test_user@example,com test_user_at_foo.org name@example.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
        invalid_addresses.each do |invalid_address|
          test_user.email = invalid_address
          expect(test_user).not_to be_valid, "#{invalid_address.inspect} should be invalid"
        end
      end

      it "emailが一意ではない場合、無効である" do
        duplicate_user = test_user.dup
        test_user.save
        expect(duplicate_user).not_to be_valid
      end
    end

    describe "phone" do
      it "phoneがない場合、無効である" do
        test_user.phone = " "
        expect(test_user).not_to be_valid
      end

      it "電話番号以外のフォーマット場合、無効である" do
        invalid_phones = %w[aaabbbbcccc 0a000000000 000000000]
        invalid_phones.each do |invalid_phone|
          test_user.phone = invalid_phone
          expect(test_user).not_to be_valid, "#{invalid_phone.inspect} should be invalid"
        end
      end
    end

    describe "password" do
      it "passwordがない場合、無効である" do
        test_user.password = test_user.password_confirmation = " "
        expect(test_user).not_to be_valid
      end

      it "パスワードが6文字未満の場合、無効である" do
        test_user.password = test_user.password_confirmation = "a" * 5
        expect(test_user).not_to be_valid
      end
    end
  end
end
