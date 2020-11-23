require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  describe "GET /new" do
    let!(:user) { create :user }

    before do
      sign_in_as user
      get new_reservation_path
    end

    it "new_reservation response success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    let!(:reservation) { create :reservation }
    let!(:user)  { create :user }
    let!(:admin) { create :admin }

    context "user" do
      before do
        sign_in_as user
        get reservations_path
      end

      it "reservatino response success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "admin" do
      before do
        sign_in_as admin
        get reservations_path
      end

      it "admin reservations response" do
        expect(response).to have_http_status(:success)
      end

      it "reservations response.body test" do
        expect(response.body).to include reservation.name
        expect(response.body).to include reservation.start_time.to_s
      end
    end
  end
end
