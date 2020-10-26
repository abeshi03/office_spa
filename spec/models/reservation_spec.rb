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
end
