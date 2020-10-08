require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  describe "login_page" do
    let!(:user) { create :user }

    before do
      visit login_path
    end

    it "flash_messages test" do
      expect(current_path).to eq login_path
      fill_in "メールアドレス", with: ""
      fill_in "パスワード", with: ""
      click_on "ログインする"
      expect(page).to have_content "ログインに失敗しました"
      visit root_path
      expect(page).not_to have_content "ログインに失敗しました"
    end

    it "login success" do
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_on "ログインする"
      expect(current_path).to eq "/users/#{user.id}"
    end
  end
end
