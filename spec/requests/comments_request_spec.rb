require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "request/comment" do
    let!(:user) { create :user }
    let!(:comment) { create :comment }
    let!(:request) { create :request }

    before do
      sign_in_as user
      get request_path(request.id)
    end

    it "comment content body test" do
      expect(response.body).to include "コメントを入力"
      expect(response.body).to include "投稿"
    end
  end
end
