require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:comment) { create :comment }

  it "comment success" do
    expect(comment).to be_valid
  end

  it "comment nil" do
    comment.comment_content = nil
    expect(comment).not_to be_valid
  end

  it "comment present" do
    comment.comment_content = ""
    expect(comment).not_to be_valid
  end

  it "comment characters 99" do
    comment.comment_content = "a" * 99
    expect(comment).to be_valid
  end

  it "comment characters 101" do
    comment.comment_content = "a" * 101
    expect(comment).not_to be_valid
  end
end
