require 'rails_helper'

RSpec.describe "Reservations", type: :system do
  describe "reservation/new" do
    let!(:user) { create :user }
    let!(:reservation) { create :reservation }

    before do
      log_in_as user
      visit new_reservation_path
    end

    it "name is nil" do
      fill_in "フルネーム(必ずご自身のお名前)", with: nil
      click_on "登録する"
      expect(page).to have_content "フルネームを入力してください"
    end

    it "time error test" do
      fill_in "フルネーム(必ずご自身のお名前)", with: reservation.name
      click_on "登録する"
      expect(page).to have_content "予約日時(時間)は13:15もしくは19:15になります"
    end

    it "menu link test" do
      click_on "メニューを確認する"
      expect(current_path).to eq menus_path
    end

    it "reservations path link test" do
      click_on "予約表を確認する"
      expect(current_path).to eq reservations_path
    end

    context "admin" do
      let!(:admin) { create :admin }
      let!(:reservation) { create :reservation }

      before do
        click_on "ログアウト"
        log_in_as admin
        visit reservations_path
      end

      it "admin only link test" do
        expect(page).to have_content reservation.name
        expect(page).to have_content reservation.start_time.to_s
        click_on "削除"
        expect(page).to have_content "予約を削除しました"
        click_on "予約したい方はこちら"
        expect(current_path).to eq new_reservation_path
      end
    end
  end
end
