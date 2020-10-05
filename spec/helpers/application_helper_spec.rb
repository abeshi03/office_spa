require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "title_test" do
    let!(:BASE_TITLE) { "オフィスパ" }

    context "page_title is nil" do
      it "full_title is オフィスパ" do
        expect(full_title(nil)).to eq Const::BASE_TITLE
      end
    end

    context "page_title is blrank" do
      it "full_title is BASE_TITLE" do
        expect(full_title("")).to eq Const::BASE_TITLE
      end
    end

    context "page_title is test" do
      it "full_title is test - BASE_TITLE" do
        expect(full_title("test")).to eq "test - #{Const::BASE_TITLE}"
      end
    end

    context "if there is no page_title argument" do
      it "full_title is base_title!" do
        expect(full_title({})).to eq Const::BASE_TITLE
      end
    end
  end
end
