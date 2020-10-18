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
end
