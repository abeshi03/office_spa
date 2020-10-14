require 'rails_helper'

RSpec.describe Request, type: :model do
  let!(:request) { create :request }

  it "request success" do
    expect(request).to be_valid
  end

  it "user is nil" do
    request.user = nil
    expect(request).not_to be_valid
  end
  
  it "content present" do
    request.content = ""
    expect(request).not_to be_valid
  end

  it "content nil" do
    request.content = nil
    expect(request).not_to be_valid
  end

  it "content characters is 100" do
    request.content = "a" * 100
    expect(request).to be_valid
  end

  it "content characters is 201" do
    request.content = "a" * 201
    expect(request).not_to be_valid
  end
end
