require 'rails_helper'

RSpec.describe "Comments", type: :system do
  describe "request/show comment" do
    let!(:comment) { create :comment }
    let!(:user) { create :user }
    let!(:request) { create :request }

    before do
      log_in_as user
      visit request_path(request.id)
    end

    it "comment create success" do
      fill_in "comment", with: comment.comment_content
      click_on "投稿"
      expect(page).to have_content "コメントしました"
      expect(page).to have_content comment.comment_content
    end

    it "comment_content nil" do
      fill_in "comment", with: nil
      click_on "投稿"
      expect(page).not_to have_content "コメントしました"
      expect(page).to have_content "コメントを入力してください"
    end

    it "comment_content character 200" do
      fill_in "comment", with: "a" * 200
      click_on "投稿"
      expect(page).to have_content "コメントは100文字以内で入力してください"
    end
  end
end
