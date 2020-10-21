require 'rails_helper'

RSpec.describe "Menus", type: :system do
  describe "menus/index" do
    let!(:user)  { create :user } 
    let!(:admin) { create :admin}
    let!(:menu)  { create :menu }

    context "user" do
      before do
        log_in_as user
        visit menus_path
      end

      it "menu_path link test" do
        click_on "口コミを書く"
        expect(current_path).to eq menu_path(menu.id)
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
        click_on "メニューを削除する"
        expect(page).to have_content "メニューを削除しました"
      end
    end
  end

  describe "menu/show" do
    let!(:user)   { create :user }
    let!(:menu)   { create :menu }
    let!(:review) { create :review }

    before do
      log_in_as user
      visit menu_path(menu.id)
    end

    it "review page link test" do
      click_on "口コミを確認する"
      expect(current_path).to eq menu_reviews_path(menu.id)
    end

    it "review post test" do
      find('.review_content').set(review.content)
      find('#rating-value', visible: false).set(review.score)
      click_on "口コミを投稿する"
      expect(current_path).to eq menu_reviews_path(menu.id)
    end

    it "content is nil error message" do
      find('.review_content').set(nil)
      find('#rating-value', visible: false).set(review.score)
      click_on "口コミを投稿する"
      expect(page).to have_content "口コミを入力してください"
    end

    it "score is nil error message" do
      find('.review_content').set(review.content)
      find('#rating-value', visible: false).set(nil)
      click_on "口コミを投稿する"
      expect(page).to have_content "星評価を入力してください"
    end
  end
end
