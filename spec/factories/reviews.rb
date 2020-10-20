FactoryBot.define do
  factory :review do
    user { nil }
    manu { nil }
    content { "MyString" }
    score { 1 }
  end
end
