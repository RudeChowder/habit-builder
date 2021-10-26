require "rails_helper"

RSpec.describe HabitCheckin, type: :model do
  describe "associations" do
    it "belongs_to a habit" do
      should respond_to(:habit)
    end

    it "belongs_to a checkin" do
      should respond_to(:checkin)
    end
  end
end
