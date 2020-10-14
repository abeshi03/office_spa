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
  end
end
