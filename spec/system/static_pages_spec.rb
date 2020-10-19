require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "StaticPages/home" do
    before do
      visit root_path
    end

    it "signup link test" do
      click_on "新規登録"
      expect(current_path).to eq signup_path
    end

    it "click_test is logo" do
      find(".logo").click
      expect(current_path).to eq root_path
    end

    it "login link test" do
      click_on "ログイン"
      expect(current_path).to eq login_path
    end
  end

  describe "SatticPages/top" do
    let!(:user) { create :user }

    context "for user" do
      before do
        log_in_as user
      end

      it "my page test" do
        find(".user_link").click
        expect(current_path).to eq "/users/#{user.id}"
      end

      it "request page link test" do
        click_on "要望"
        expect(current_path).to eq new_request_path
      end

      it "manu page link test" do
        click_on "メニュー"
        expect(current_path).to eq menus_path
      end

      it "staff page link test" do
        click_on "スタッフ"
        expect(current_path).to eq staff_path
      end
    end
  end
end
