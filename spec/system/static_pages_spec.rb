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
    context "for user" do
      let!(:user) { create :user }
      let!(:menu) { create :menu }

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

      it "review page link test" do
        click_on "口コミ"
        expect(current_path).to eq new_review_path
      end

      it "new_review_path link test" do
        click_on "口コミ"
        click_on "口コミを書く"
        expect(current_path).to eq "/menus/#{menu.id}"
        visit new_review_path
        click_on "口コミを見る"
        expect(current_path).to eq "/menus/#{menu.id}/reviews"
      end

      it "new_reservation_path link test" do
        click_on "予約する"
        expect(current_path).to eq "/reservations/new"
      end
    end

    context "for admin" do
      let!(:admin) { create :admin }
      let!(:menu)  { create :menu }

      before do
        log_in_as admin
      end

      it "requests page link test" do
        click_on "要望確認"
        expect(current_path).to eq requests_path
      end

      it "new_manu page link test" do
        click_on "メニュー投稿"
        expect(current_path).to eq new_menu_path
      end

      it "users page link test" do
        click_on "ユーザー一覧"
        expect(current_path).to eq users_path
      end

      it "reservations page link test" do
        click_on "予約確認"
        expect(current_path).to eq reservations_path
      end

      it "reservations page test for footer" do
        click_on "予約一覧"
        expect(current_path).to eq reservations_path
      end
    end
  end
end
