require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user) }
  let(:other) { create(:other) }
  let(:request) { create(:request) }

  it "I can't like the same request" do
    user.favorites.create(request_id: request.id)
    new_favorite = user.favorites.create(request_id: request.id)
    expect(new_favorite).to be_invalid
  end

  it "different users can favorite" do
    user.favorites.create(request_id: request.id)
    new_favorite = other.favorites.create(request_id: request.id)
    expect(new_favorite).to be_valid
  end
end
