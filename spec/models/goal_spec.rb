require "rails_helper"

RSpec.describe Goal, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:habit) }
  end

  describe "validations" do
    it { should validate_presence_of(:target) }
    it do
      should validate_numericality_of(:target).
        is_greater_than(0)
    end
  end

  describe ".new" do
    it "is valid with appropriate attributes" do
      goal = build(:goal)

      expect(goal).to be_valid
    end
  end

  describe "#check_completion" do
    it "becomes achieved when target is met" do
      user = create(:user)
      habit = create(:habit)
      goal = create(:goal, target: 1, user: user, habit: habit)
      checkin = build(:checkin, user: user)
      checkin.habits << habit
      checkin.save

      goal.reload

      expect(goal.achieved).to eq true
    end
  end
end
