FactoryBot.define do
  factory :request do
    content { "MyText" }
    user
  end
end
