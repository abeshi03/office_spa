require 'rails_helper'

RSpec.describe Review, type: :model do
  let!(:user)   { create :user }
  let!(:menu)   { create :menu }
  let!(:review) { create :review }

  it "review success" do
    expect(review).to be_valid
  end

  it "score is nil" do
    review.score = nil
    expect(review).not_to be_valid
  end

  it "score is plasent" do
    review.score = " "
    expect(review).not_to be_valid
  end

  it "content is nil" do
    review.content = nil
    expect(review).not_to be_valid
  end

  it "content is present" do
    review.content = " "
    expect(review).not_to be_valid
  end

  it "content characters is 299" do
    review.content = "a" * 299
    expect(review).to be_valid
  end

  it "content is characters is 301" do
    review.content = "a" * 301
    expect(review).not_to be_valid
  end
end
