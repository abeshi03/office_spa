require 'rails_helper'

RSpec.describe "Requests", type: :system do
  describe "request/new" do
    let!(:other) { create :other }
    let!(:request) { create :request }

    before do
      log_in_as other
      visit new_request_path
    end

    it "request success" do
      fill_in "request_firld", with: request.content
      click_on "投稿する"
      expect(page).to have_content "要望が投稿されました"
    end

    it "request content nil" do
      fill_in "request_firld", with: request.content = nil
      click_on "投稿する"
      expect(page).to have_content "要望を入力してください"
    end

    it "request content characters 201" do
      fill_in "request_firld", with: request.content = "a" * 201
      click_on "投稿する"
      expect(page).to have_content "要望は200文字以内で入力してください"
    end

    it "go to request index success" do
      click_on "要望一覧はこちら"
      expect(current_path).to eq requests_path
    end
  end

  describe "request/index" do
    let!(:other) { create :other }
    let!(:request) { create :request }

    before do
      log_in_as other
      visit requests_path
    end

    it "new_request_path link test" do
      click_on "要望を投稿する"
      expect(current_path).to eq new_request_path
    end

    it "request_show link test" do
      first(".comment-icon").click
      expect(current_path).to eq requests_path
    end
  end

  describe "request/show/destroy" do
    let!(:second_user) { create :second_user }
    let!(:request) { create :request }

    before do
      log_in_as second_user
      visit request_path(request.id)
    end

    it "request name" do
      expect(page).to have_content request.user.name
    end

    it "request content" do
      expect(page).to have_content request.content
    end

    it "not request destroy" do
      expect(page).not_to have_content "要望を削除する"
    end
  end
end
