require 'rails_helper'

RSpec.describe Menu, type: :model do
  let!(:menu) { create :menu }

  it "menu success" do
    expect(menu).to be_valid
  end

  it "name is nil" do
    menu.name = nil
    expect(menu).not_to be_valid
  end

  it "name is present" do
    menu.name = " "
    expect(menu).not_to be_valid
  end

  it "decription is nil" do
    menu.description = nil
    expect(menu).not_to be_valid
  end

  it "description is present" do
    menu.description = " "
    expect(menu).not_to be_valid
  end

  it "description characters is 99" do
    menu.description = "a" * 99
    expect(menu).to be_valid
  end

  it "description characters is 101" do
    menu.description = "a" * 101
    expect(menu).not_to be_valid
  end

  it "category is nil" do
    menu.category = nil
    expect(menu).not_to be_valid
  end

  it "category is present" do
    menu.category = " "
    expect(menu).not_to be_valid
  end
end
