FactoryBot.define do
  factory :checkin do
    user
    date { Date.today }
    notes { "Checking in" }
    summary { "Checking in" }

    trait :with_habits do
      habits { build_list :habit, 3 }
    end
  end
end
