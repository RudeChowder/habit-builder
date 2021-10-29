require "rails_helper"

describe "When visiting the goals index", type: :system do
  before do
    @user = create(:user)
    sign_in @user
  end

  it "can see all of your goals", :aggregate_failures do
    habit = create(:habit, name: "Practice specs")
    goal1 = create(:goal, user: @user, habit: habit, target: 10)
    goal2 = create(:goal, user: @user, habit: habit, target: 1, achieved: true)

    visit user_goals_path(@user)

    expect(page).to have_content "Practice specs"
    expect(page).to have_content "Target: 10 days"
    expect(page).to have_content "Target: 1 days"
  end
end
