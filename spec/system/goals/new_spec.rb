require "rails_helper"

describe "When visiting the new goal form", type: :system do
  before do
    @user = create(:user)
    sign_in @user
  end

  it "user can create a goal for an existing habit", :aggregate_failures do
    habit = create(:habit, name: "Write Specs")

    visit new_user_goal_path(@user)

    select "Write Specs", from: "Select the habit this goal is for:"
    fill_in "What is your target for total checkins on this habit?", with: 4
    click_button "Set Goal"

    expect(page).to have_content "Write Specs"
    expect(page).to have_content "Target: 4 days"
  end

  it "user can create a goal for a new habit", :aggregate_failures do
    visit new_user_goal_path(@user)

    fill_in "New habit name", with: "Be a badass"
    fill_in "What is your target for total checkins on this habit?", with: 4
    click_button "Set Goal"

    expect(page).to have_content "Be a badass"
    expect(page).to have_content "Target: 4 days"
  end

  it "user is shown errors when submitting with invalid input" do
    visit new_user_goal_path(@user)

    click_button "Set Goal"

    expect(page).to have_content "prohibited this goal from being saved"
  end
end
