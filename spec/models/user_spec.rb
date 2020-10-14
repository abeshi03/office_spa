require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create :user }
  let!(:admin) { create :admin }

  it "user is valid" do
    expect(user).to be_valid
  end

  it "name is blank" do
    user.name = ""
    expect(user).not_to be_valid
  end

  it "name is nil" do
    user.name = nil
    expect(user).not_to be_valid
  end

  it "name is 31 characters" do
    user.name = "a" * 31
    expect(user).not_to be_valid
  end

  it "name is 29 characters" do
    user.name = "a" * 29
    expect(user).to be_valid
  end

  it "email is blank" do
    user.email = ""
    expect(user).not_to be_valid
  end

  it "email is nil" do
    user.email = nil
    expect(user).not_to be_valid
  end

  it "email is 201 characters" do
    user.email = "a" * 200 + "@gmail.com"
    expect(user).not_to be_valid
  end

  it "email is 199 characters" do
    user.email = "a" * 188 + "@gmail.com"
    expect(user).to be_valid
  end

  it "email is uniqueness" do
    user2 = User.new(name: "test", email: "test@gmail.com")
    expect(user2).not_to be_valid
  end

  it "password is blank" do
    user.password_confirmation = ""
    expect(user).not_to be_valid
  end

  it "password is characters 5" do
    user.password_confirmation = "a" * 5
    expect(user).not_to be_valid
  end

  it "authenticated? should return false for a user with nil digest" do
    user.authenticated?("")
    expect(user).to be_truthy
  end

  it "description is characters 140" do
    user.description = "a" * 141
    expect(user).not_to be_valid
  end
end
