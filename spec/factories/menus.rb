FactoryBot.define do
  factory :menu do
    name { "MyString" }
    description { "MyText" }
    category { "MyString" }
    user
  end
end
