require 'rails_helper'

RSpec.describe "GestLogins", type: :system do
  let!(:user) { create :user }

  it "root_path gest_login success" do
    visit root_path
    click_on "ゲストログイン(ユーザー)"
    login_destination
  end

  it "admin login test" do
    visit root_path
    click_on "ゲストログイン(管理者用)"
    login_destination
  end

  it "login_path gest_login success" do
    visit login_path
    click_on "ゲストでログインの方はこちら"
    login_destination
  end

  it "signup_path gest_login seccess" do
    visit signup_path
    click_on "ゲストとしてログインする"
    login_destination
  end
end
