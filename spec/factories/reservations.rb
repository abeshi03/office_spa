FactoryBot.define do
  factory :reservation do
    name { "MyString" }
    start_time { "2090-10-23 19:15" }
    user
    menu
  end
end
