require 'rails_helper'

RSpec.describe Habit, type: :model do
  describe "associations" do
    it { should have_many(:habit_checkins) }
    it { should have_many(:checkins) }
    it { should have_many(:users) }
    it { should have_many(:goals) }
  end

  describe "validations" do
    subject { FactoryBot.build(:habit) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe ".new" do
    it "is valid with appropriate attributes" do
      habit = build(:habit)

      expect(habit).to be_valid
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
