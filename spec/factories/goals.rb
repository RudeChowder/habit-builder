FactoryBot.define do
  factory :goal do
    user
    habit
    target { 5 }
    achieved { false }
  end
end
