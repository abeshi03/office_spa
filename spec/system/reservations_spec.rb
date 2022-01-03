require 'rails_helper'

RSpec.describe "Reservations", type: :system do
  describe "reservation/new" do
    context "user" do
      let!(:user) { create :user }
      let!(:reservation) { create :reservation }
      let!(:menu) { create :menu }
      let!(:menu_second) { create :menu_second }
      let!(:menu_third) { create :menu_third }

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
        select_date("2030,12,20", from: "日時(開始時間は原則13:15 or 19:15になります)")
        select_time("13", "00", from: "日時(開始時間は原則13:15 or 19:15になります)")
        click_on "登録する"
        expect(page).to have_content "予約日時(時間)は13:15もしくは19:15になります"
      end

      it "reservation menu error test" do
        fill_in "フルネーム(必ずご自身のお名前)", with: reservation.name
        select_date("2030,12,22", from: "日時(開始時間は原則13:15 or 19:15になります)")
        select_time("13", "15", from: "日時(開始時間は原則13:15 or 19:15になります)")
        select "選択してください", from: "reservation_menu_id"
        click_on "登録する"
        expect(page).to have_content "メニューを選択してください"
      end

      it "reservation success!! and destroy" do
        create_reservation
        expect(page).to have_content "予約を完了しました"
        visit "users/#{user.id}"
        expect(page).to have_content menu_second.name
        click_on "キャンセル"
        expect(page).to have_content "予約を削除しました"
      end

      it "reservation_history menu link test" do
        create_reservation
        visit "users/#{user.id}"
        click_on menu_second.name
        expect(current_path).to eq menus_path
      end
      it "menu link test" do
        click_on "メニューを確認する"
        expect(current_path).to eq menus_path
      end

      it "reservations path link test" do
        click_on "予約表を確認する"
        expect(current_path).to eq reservations_path
      end
    end

    context "admin" do
      let!(:admin) { create :admin }
      let!(:reservation) { create :reservation }
      let!(:menu) { create :menu }
      let!(:menu_second) { create :menu_second }
      let!(:menu_third) { create :menu_third }

      before do
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

      it "There are two future dates" do
        visit "/reservations?start_date=2090-10-1"
        expect(page).to have_content reservation.name, count: 2
      end
    end
  end
end
