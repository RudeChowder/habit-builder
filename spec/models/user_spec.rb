require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:checkins) }
    it { should have_many(:habits) }
    it { should have_many(:goals) }
  end

  describe "#short_name" do
    it "returns the first part of the user email" do
      user = build(:user, email: "carl@gmail.com")

      expect(user.short_name).to eq("carl")
    end
  end

  describe "#current_habits" do
    it "returns a unique list of the user's habits" do
      jog = create(:habit, name: "Jog")
      read = create(:habit, name: "Read")
      user = build(:user)

      create_checkin_for_user_and_habit(user, jog)
      create_checkin_for_user_and_habit(user, read)
      create_checkin_for_user_and_habit(user, jog)

      expect(user.current_habits).to match_array [jog, read]
    end
  end

  describe "#last_three_checkins" do
    it "returns the three most recent checkins" do
      user = create(:user)
      habit = create(:habit)
      4.times do
        create_checkin_for_user_and_habit(user, habit)
      end
      checkin = build(:checkin, user: user, date: Date.yesterday)
      checkin.habits << habit
      checkin.save

      expect(user.last_three_checkins).to_not include habit
    end
  end

  describe "#checkin_count_for_habit" do
    it "returns the total amount of checkins for a specific habit" do
      user = create(:user)
      habit = create(:habit)
      2.times do
        create_checkin_for_user_and_habit(user, habit)
      end

      expect(user.checkin_count_for_habit(habit)).to eq 2
    end
  end

  def create_checkin_for_user_and_habit(user, habit)
    checkin = build(:checkin, user: user)
    checkin.habits << habit
    checkin.save
  end
end
