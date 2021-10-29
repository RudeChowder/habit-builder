require "rails_helper"

describe "For the Checkin card", type: :system do
  before do
    @user = create(:user)
    sign_in @user
  end

  it "clicking 'edit' takes you to the edit form" do
    checkin = create(:checkin, :with_one_habit, user: @user, notes: "Wrote some specs")

    visit user_checkins_path(@user)

    click_link "Edit"

    expect(page).to have_field(checkin.habits.first.name, checked: true)
    expect(page).to have_content "Wrote some specs"
  end

  it "clicking 'delete' destroys the checkin" do
    create(:checkin, :with_one_habit, user: @user, notes: "Wrote some specs")

    visit user_checkins_path(@user)

    accept_confirm do
      click_link "Delete"
    end

    expect(page).not_to have_content "Wrote some specs"
    expect(page).not_to have_content "Write 5 lines of code"
  end
end
