require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  describe "login_page" do
    let!(:user) { create :user }
    let!(:other) { create :other}

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

    it "login and logout success" do
      log_in_as user
      expect(current_path).to eq top_path
      expect(page).to have_content "ログアウト"
      click_on "ログアウト"
      expect(current_path).to eq root_path
      expect(page).to have_content "ログアウトしました"
      delete logout_path
    end

    it "signup link test" do
      click_on "新規登録はこちら"
      expect(current_path).to eq signup_path
    end

    it "footer test" do
      log_in_as user
      expect(page).to have_content "ホーム"
      expect(page).to have_content "予約"
      expect(page).to have_content "マイページ", count: 2
      expect(page).to have_content "ログアウト"
    end

    it "checkbox test" do
      check "ログイン情報を記憶する"
      log_in_as user
      delete logout_path
      expect(cookies[:remember_token]).to be_nil
    end

    it "don't go to user_edit_path without logging in" do
      visit edit_user_path(user.id)
      expect(page).to have_content "ログインしていません"
      log_in_as user
      expect(current_path).to eq edit_user_path(user.id)
    end

    it "other users' pages cannot be edited" do
      log_in_as user
      visit edit_user_path(other.id)
      expect(current_path).to eq root_path
    end
  end

  describe "Login restrictions" do
    let!(:user) { create :user }

    it "no_login users_path access" do
      visit users_path
      not_open_page
    end

    it "no_login edit_path" do
      visit edit_user_path(user.id)
      not_open_page
    end
  end
end
