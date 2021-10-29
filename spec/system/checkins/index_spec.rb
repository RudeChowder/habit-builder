require "rails_helper"

describe "When visiting the checkins index", type: :system do
  before do
    @user = create(:user)
    sign_in @user
  end

  it "all of the checkins are displayed" do
    checkin1 = create(:checkin, :with_one_habit, user: @user)
    checkin2 = create(:checkin, :with_one_habit, user: @user)

    visit user_checkins_path(@user)

    expect(page).to have_content checkin1.pretty_date
    expect(page).to have_content checkin2.pretty_date
    expect(page).to have_content checkin1.habits.first.name
    expect(page).to have_content checkin2.habits.first.name
  end
end
