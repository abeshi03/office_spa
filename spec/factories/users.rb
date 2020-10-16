FactoryBot.define do
  factory :user do
    name { "test" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }
  end

  factory :other, class: User do
    name { "other" }
    email { "other@gmail.com" }
    password { "password" }
  end

  factory :users, class: User do
    name { "users" }
    sequence(:email) { |n| "users#{n}@gmail.com" }
    password { "password" }
  end

  factory :admin, class: User do
    name { "admin" }
    email { "admin@gmail.com" }
    password { "password" }
    admin { true }
  end

  factory :second_user, class: User do
    name { "second" }
    email { "second@gmail.com" }
    password { "password" }
  end
end
