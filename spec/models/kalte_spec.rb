require 'rails_helper'

RSpec.describe Kalte, type: :model do
  let(:test_kalte) { FactoryBot.create(:kalte) }
  context "カルテ情報が有効な場合" do
    it "カルテ情報が有効である" do
      expect(test_kalte).to be_valid
    end
  end

  context "カルテ情報が無効な場合" do
    describe "menu" do
      it "menuがない場合、無効である" do
        test_kalte.menu = " "
        expect(test_kalte).not_to be_valid
      end

      it "menuが50文字を超える場合、無効である" do
        test_kalte.menu = "a" * 51
        expect(test_kalte).not_to be_valid
      end
    end

    describe "request" do
      it "requestがない場合、無効である" do
        test_kalte.request = " "
        expect(test_kalte).not_to be_valid
      end

      it "requestが500文字を超える場合、無効である" do
        test_kalte.request = "a" * 501
        expect(test_kalte).not_to be_valid
      end
    end

    describe "menu_description" do
      it "menu_descriptionがない場合、無効である" do
        test_kalte.menu_description = " "
        expect(test_kalte).not_to be_valid
      end

      it "menu_descriptionが500文字を超える場合、無効である" do
        test_kalte.menu_description = "a" * 501
        expect(test_kalte).not_to be_valid
      end
    end

    describe "note" do
      it "noteがない場合、無効である" do
        test_kalte.note = " "
        expect(test_kalte).not_to be_valid
      end

      it "noteが500文字を超える場合、無効である" do
        test_kalte.note = "a" * 501
        expect(test_kalte).not_to be_valid
      end
    end
  end
end
