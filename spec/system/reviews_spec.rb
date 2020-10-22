require 'rails_helper'

RSpec.describe "Reviews", type: :system do
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

  describe "review/destroy" do
    let!(:user)   { create :user }
    let!(:menu)   { create :menu }
    let!(:review) { create :review }
    let!(:admin)  { create :admin }

    context "user" do
      before do
        log_in_as user
        visit menu_reviews_path(menu.id)
      end

      it "review destroy success" do
        visit menu_path(menu.id)
        find('.review_content').set(review.content)
        find('#rating-value', visible: false).set(review.score)
        click_on "口コミを投稿する"
        expect(page).to have_content "口コミを投稿しました"
        click_on "口コミを削除する"
        expect(page).to have_content "口コミを削除しました"
      end

      it "review_post link test" do
        click_on "口コミを投稿する"
        expect(current_path).to eq menu_path(menu.id)
      end
    end

    context "admin" do
      before do
        log_in_as admin
        visit menu_reviews_path(menu.id)
      end

      it "not destroy btn" do
        expect(page).not_to have_content "口コミを削除する"
      end
    end
  end
end
