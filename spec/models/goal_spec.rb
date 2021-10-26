require "rails_helper"

RSpec.describe Goal, type: :model do
  describe "associations" do
    it "belongs_to a user" do
      should respond_to(:user)
    end

    it "belongs_to a habit" do
      should respond_to(:habit)
    end
  end

  describe ".new" do
    it "is valid with appropriate attributes" do
      goal = build(:goal)

      expect(goal).to be_valid
    end

    it "is invalid without a target" do
      goal = build(:goal, target: nil)

      expect(goal).not_to be_valid
    end

    it "is invalid with a negative target" do
      goal = build(:goal, target: -5)

      expect(goal).not_to be_valid
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
