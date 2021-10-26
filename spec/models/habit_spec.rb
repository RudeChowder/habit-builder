require 'rails_helper'

RSpec.describe Habit, type: :model do
  describe "associations" do
    it "has_many habit_checkins" do
      should respond_to(:habit_checkins)
    end

    it "has_many checkins" do
      should respond_to(:checkins)
    end

    it "has_many users" do
      should respond_to(:users)
    end

    it "has_many goals" do
      should respond_to(:goals)
    end
  end

  describe ".new" do
    it "is valid with appropriate attributes" do
      habit = build(:habit)

      expect(habit).to be_valid
    end

    it "is invalid without a name" do
      habit = build(:habit, name: nil)

      expect(habit).to_not be_valid
    end

    it "is invalid with a duplicated name" do
      create(:habit, name: "Stop Repeating Myself")
      habit = build(:habit, name: "Stop Repeating Myself")

      expect(habit).to_not be_valid
    end

  end

  describe "#oldest_checkin_for_user" do
    it "returns the oldest checkin for specified user" do
      habit = create(:habit)
      user = create(:user)
      old_checkin = build(:checkin, user: user, date: "Mon, 18 Oct 2021")
      new_checkin = build(:checkin, user: user, date: "Tue, 19 Oct 2021")
      add_habit_to_checkin(habit, old_checkin)
      add_habit_to_checkin(habit, new_checkin)
      old_checkin.save
      new_checkin.save

      expect(habit.oldest_checkin_for_user(user)).to eq(old_checkin)
    end
  end

  def add_habit_to_checkin(habit, checkin)
    checkin.habits << habit
  end
end
