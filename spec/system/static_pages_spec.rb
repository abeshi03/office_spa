require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "StaticPages/home" do
    before do
      visit root_path
    end

    it "signup link test" do
      click_on "新規登録"
      expect(current_path).to eq signup_path
    end

    it "click_test is logo" do
      find(".logo").click
      expect(current_path).to eq root_path
    end
  end
end
