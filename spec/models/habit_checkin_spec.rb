require "rails_helper"

RSpec.describe HabitCheckin, type: :model do
  describe "associations" do
    it { should belong_to(:checkin) }
    it { should belong_to(:habit) }
  end
end
