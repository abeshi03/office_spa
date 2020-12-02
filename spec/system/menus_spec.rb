require 'rails_helper'

RSpec.describe "Menus", type: :system do
  describe "menus/index" do
    let!(:user)  { create :user }
    let!(:admin) { create :admin }
    let!(:menu)  { create :menu }
    let!(:menu_second) { create :menu_second }
    let!(:menu_third) { create :menu_third }

    context "user" do
      before do
        log_in_as user
        visit menus_path
      end

      it "menu_path link test" do
        first(".review_right_btn").click
        expect(current_path).to eq menu_path(menu.id)
      end

      it "reservation link test" do
        first(".menu_btn").click
        expect(current_path).to eq new_reservation_path
      end
    end

    context "admin" do
      before do
        log_in_as admin
        visit menus_path
      end

      it "new_menu_path link test" do
        click_on "メニューを追加する"
        expect(current_path).to eq new_menu_path
      end

      it "menu destroy" do
        first(".menu_delete").click
        expect(page).to have_content "メニューを削除しました"
      end
    end
  end
end
