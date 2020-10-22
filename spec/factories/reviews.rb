FactoryBot.define do
  factory :review do
    user
    menu
    content { "MyString" }
    score { 1 }
  end
end
