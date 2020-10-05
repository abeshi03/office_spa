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
end
