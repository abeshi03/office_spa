require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let!(:reservation) { create :reservation }

  it "reservation is success" do
    expect(reservation).to be_valid
  end

  it "name is nil" do
    reservation.name = nil
    expect(reservation).not_to be_valid
  end

  it "name is present" do
    reservation.name = " "
    expect(reservation).not_to be_valid
  end

  it "user is nil" do
    reservation.user = nil
    expect(reservation).not_to be_valid
  end

  it "start_time is 13:15" do
    reservation.start_time = "2090-10-23 13:15:00"
    expect(reservation).to be_valid
  end

  it "start_time is 13:14" do
    reservation.start_time = "2090-10-23 13:14:00"
    expect(reservation).not_to be_valid
  end

  it "start_time is sunday" do
    reservation.start_time = "sunday"
    expect(reservation).not_to be_valid
  end

  it "start_time is saturday" do
    reservation.start_time = "saturday"
    expect(reservation).not_to be_valid
  end

  it "past dates cannot be selected" do
    reservation.start_time = "2019-10-23 13:14:00"
    expect(reservation).not_to be_valid
  end

  it "munu_id is nil" do
    reservation.menu = nil
    expect(reservation).not_to be_valid
  end

  describe "scope" do
    let!(:reservations_1) { create :reservation, name: "1", start_time: "2070-10-23 13:15" }
    let!(:reservations_2) { create :reservation, name: "2", start_time: "2070-10-22 13:15" }
    let!(:reservations_3) { create :reservation, name: "3", start_time: "2070-10-22 19:15" }

    it "All future reservations are displayed" do
      expect(Reservation.future_reservations.length).to eq 4
    end

    it "Up to 2 cases reservations_history" do
      expect(Reservation.reservations_history(2).length).to eq 2
    end

    it "Up to 4 cases reservations_history" do
      expect(Reservation.reservations_history(5).length).to eq 4
    end
  end
end
