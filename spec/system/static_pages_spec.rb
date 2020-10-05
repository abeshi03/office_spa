require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "static_pages#home" do
    before do
      visit root_path
    end

    it "click the logo to go to the top page" do
      find(".logo").click
      expect(current_path).to eq root_path
    end
  end
end
