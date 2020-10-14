require 'rails_helper'

RSpec.describe "Requests", type: :request do
  describe "GET /new" do
    let!(:user) { create :user }

    before do
      sign_in_as user
      get new_request_path
    end

    it "new_request_path response" do
      expect(response).to have_http_status(:success)
    end

    it "new_request_page include test" do
      expect(response.body).to include "要望"
      expect(response.body).to include "投稿する"
      expect(response.body).to include "例、、ハンドマッサージのメニューを追加してほしい"
      expect(response.body).to include "新しいメニューの要望があったら投稿しよう"
    end
  end
end
