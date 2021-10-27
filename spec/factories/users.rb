FactoryBot.define do
  factory :user do
    sequence(:email, 1) { |n| "steve#{n}@gmail.com" }
    password { "password" }
  end
end
