FactoryBot.define do
  factory :comment do
    comment_content { "MyString" }
    user
    request
  end
end
