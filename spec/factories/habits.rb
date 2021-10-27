FactoryBot.define do
  factory :habit do
    sequence(:name, 5) { |n| "Write #{n} lines of code" }
    image { "img.jpg" }
  end
end
