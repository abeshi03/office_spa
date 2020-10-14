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
end
