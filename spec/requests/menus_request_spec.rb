require 'rails_helper'

RSpec.describe "Menus", type: :request do
  describe "menu/new" do
    let!(:menu) { create :menu }
    let!(:admin) { create :admin }
    let!(:user) { create :user }

    context "admin" do
      before do
        sign_in_as admin
        get new_menu_path
      end

      it "responce success" do
        expect(response).to have_http_status(:success)
      end

      it "response content" do
        expect(response.body).to include "メニュー名"
        expect(response.body).to include "説明"
        expect(response.body).to include "カテゴリー"
        expect(response.body).to include "メニューを追加する"
        expect(response.body).to include "メニュー一覧はこちら"
      end
    end

    context "not admin" do
      before do
        sign_in_as user
        get new_menu_path
      end

      it "response not success" do
        expect(response).not_to have_http_status(:success)
      end
    end
  end

  describe "menu/index" do
    let!(:user) { create :user }
    let!(:admin) { create :admin }
    let!(:menu) { create :menu }

    context "user" do
      before do
        sign_in_as user
        get menus_path
      end

      it "index page response" do
        expect(response).to have_http_status(:success)
      end

      it "menus page response body" do
        expect(response.body).to include "メニュー一覧"
        expect(response.body).to include menu.name
        expect(response.body).to include menu.description
        expect(response.body).to include menu.category
        expect(response.body).to include "予約する"
      end
    end

    context "admin" do
      before do
        sign_in_as admin
        get menus_path
      end

      it "admin response success" do
        expect(response).to have_http_status(:success)
      end

      it "admin only link" do
        expect(response.body).to include "メニューを削除する"
        expect(response.body).to include "メニューを追加する"
      end
    end
  end
end
