require "rails_helper"

describe "For the Goal card", type: :system do
  before do
    @user = create(:user)
    sign_in @user
  end

  it "clicking 'edit' takes you to the edit form" do
    habit = create(:habit)
    create(:goal, user: @user, habit: habit, target: 100)

    visit user_goals_path(@user)

    click_link "Edit"

    expect(page).to have_content "100"
  end

  it "clicking 'delete' destroys the checkin" do
    habit = create(:habit)
    create(:goal, user: @user, habit: habit, target: 100)

    visit user_goals_path(@user)

    accept_confirm do
      click_link "Delete"
    end

    expect(page).to_not have_content "Target: 100 days"
  end
end
