require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /new" do
    before do
      get login_path
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "login string test" do
      expect(response.body).to include "ログイン"
    end

    it "there should be a label and a link" do
      expect(response.body).to include "メールアドレス"
      expect(response.body).to include "パスワード"
      expect(response.body).to include "新規登録はこちら"
      expect(response.body).to include "ゲストでログインの方はこちら"
    end
  end
end