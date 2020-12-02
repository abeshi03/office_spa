FactoryBot.define do
  factory :menu do
    name { "MyString" }
    description { "MyText" }
    category { "MyString" }
    user
  end

  factory :menu_second, class: Menu do
    name { "SecondString" }
    description { "SecondText" }
    category { "SecondString" }
    user
  end

  factory :menu_third, class: Menu do
    name { "ThirdString" }
    description { "ThirdText" }
    category { "ThirdString" }
    user
  end
end
