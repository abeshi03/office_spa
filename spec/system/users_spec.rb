require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create :user }

  describe "/signup" do
    before do
      visit signup_path
    end

    it "click is logo" do
      find(".logo").click
      expect(current_path).to eq root_path
    end

    it "new registration test" do
      fill_in "フルネーム", with: "hogehoge"
      fill_in "メールアドレス", with: "hogehoge@gmail.com"
      fill_in "パスワード(6文字以上)", with: "hogehoge"
      fill_in "パスワード(確認用)", with: "hogehoge"
      click_button "作成する"
      expect(page).to have_content "さっそく予約してみよう！"
      expect(current_path).to eq top_path
    end

    it "errors_full_messages test" do
      fill_in "フルネーム", with: ""
      fill_in "メールアドレス", with: ""
      fill_in "パスワード(6文字以上)", with: ""
      fill_in "パスワード(確認用)", with: ""
      click_on "作成する"
      expect(page).to have_content "フルネームを入力してください"
      expect(page).to have_content "メールアドレスを入力してください"
      expect(page).to have_content "メールアドレスは不正な値です"
      expect(page).to have_content "パスワードを入力してください"
      fill_in "フルネーム", with: "test_user"
      fill_in "メールアドレス", with: "test_user@gmail.com"
      fill_in "パスワード(6文字以上)", with: "testuser"
      fill_in "パスワード(確認用)", with: "usertest"
      click_on "作成する"
      expect(page).to have_content "パスワード(確認用)とパスワードの入力が一致しません"
    end
  end

  describe "/users/:id/edit" do
    let!(:user) { create :user }

    before do
      log_in_as user
      visit edit_user_path(user.id)
    end

    it "user edit" do
      expect(current_path).to eq "/users/#{user.id}/edit"
      fill_in "名前", with: "edit_user"
      fill_in "メールアドレス", with: "edit@gmail.com"
      fill_in "パスワード(６文字以上)", with: "password"
      fill_in "パスワード(確認用)", with: "password"
      click_on "編集する"
      expect(current_path).to eq "/users/#{user.id}"
      expect(page).to have_content "ユーザーを編集しました"
    end
  end

  describe "/users" do
    let!(:users) { create_list(:users, 5) }
    let!(:admin) { create :admin }

    before do
      log_in_as admin
      visit users_path
    end

    it "users count test" do
      expect(current_path).to eq users_path
      users.each do |user|
        expect(page).to have_content user.name, count: 5
      end
      expect(page).to have_content admin.name
    end
  end
end
