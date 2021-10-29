require "rails_helper"

describe "When a user views their profile", type: :system do
  before do
    @user = create(:user)
    sign_in @user
  end

  it "they can see their info", :aggregate_failures do
    habit = create(:habit, name: "Write system tests")
    goal = create(:goal, user: @user, habit: habit, target: 100)
    checkin = build(:checkin, user: @user, date: Date.today)
    checkin.habits << habit
    checkin.save

    visit "/"

    click_link "Profile"

    expect(page).to have_content "Write system tests"
    expect(page).to have_content "Target: 100 days"
    expect(page).to have_content "#{checkin.pretty_date}"

  end
end
