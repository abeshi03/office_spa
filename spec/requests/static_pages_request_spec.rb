require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /home" do
    before do
      get root_path
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "there should be the specified character" do
      expect(response.body).to include "ログイン"
      expect(response.body).to include "新規登録"
      expect(response.body).to include "ゲストログイン"
    end
  end

  describe "GET /top" do
    context "for user" do
      let!(:user) { create :user }

      before do
        sign_in_as user
        get top_path
      end

      it "returns http success is top_page" do
        expect(response).to have_http_status(:success)
      end

      it "select button test" do
        expect(response.body).to include "メニュー"
        expect(response.body).to include "スタッフ"
        expect(response.body).to include "要望"
        expect(response.body).to include "マイページ"
        expect(response.body).to include "口コミ"
        expect(response.body).to include "予約する"
      end
    end

    context "for admin" do
      let!(:admin) { create :admin }

      before do
        sign_in_as admin
        get top_path
      end

      it "select button test" do
        expect(response.body).to include "メニュー投稿"
        expect(response.body).to include "要望確認"
        expect(response.body).to include "ユーザー一覧"
        expect(response.body).to include "口コミ確認"
        expect(response.body).to include "予約確認"
      end
    end
  end
end
