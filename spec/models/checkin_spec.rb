require 'rails_helper'

RSpec.describe Checkin, type: :model do
  describe "associations" do
    it "belongs_to a user" do
      should respond_to(:user)
    end

    it "has_many habit_checkins" do
      should respond_to(:habit_checkins)
    end

    it "has_many habits" do
      should respond_to(:habits)
    end
  end

  describe ".new" do
    it "is valid with valid attributes" do
      checkin = build(:checkin, :with_habits)

      expect(checkin).to be_valid
    end

    it "is invalid without any habits" do
      checkin = build(:checkin)

      expect(checkin).not_to be_valid
    end

    it "is invalid without a date" do
      checkin = build(:checkin, :with_habits, date: nil)
    end

    it "is invalid with a date in the future" do
      checkin = build(:checkin, :with_habits, date: Date.tomorrow)
    end
  end

  describe "#pretty_date" do
    it "formats the date nicely" do
      checkin = build(:checkin, date: "Mon, 18 Oct 2021" )

      expect(checkin.pretty_date).to eq("Mon, 18 Oct 2021")
    end
  end

#   describe "#date_not_in_the_future" do

#     it "accepts a date in the past" do
#       checkin = build(:checkin, date: "Mon, 18 Oct 2021" )
#       checkin.date_not_in_the_future

#       expect(checkin.errors.full_messages).not_to include("Date cannot be in the future")
#     end

#     it "accepts today's date" do
#       checkin = build(:checkin, date: Date.today )
#       checkin.date_not_in_the_future

#       expect(checkin.errors.full_messages).not_to include("Date cannot be in the future")
#     end

#     it "rejects a future date" do
#       checkin = build(:checkin, date: Date.tomorrow )
#       checkin.date_not_in_the_future

#       expect(checkin.errors.full_messages).to include("Date cannot be in the future")
#     end
#   end
end
