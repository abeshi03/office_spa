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
      expect(page).to have_content "パスワードは6文字以上で入力してください"
      fill_in "フルネーム", with: "test_user"
      fill_in "メールアドレス", with: "test_user@gmail.com"
      fill_in "パスワード(6文字以上)", with: "testuser"
      fill_in "パスワード(確認用)", with: "usertest"
      click_on "作成する"
      expect(page).to have_content "パスワード(確認用)とパスワードの入力が一致しません"
    end
  end
end
