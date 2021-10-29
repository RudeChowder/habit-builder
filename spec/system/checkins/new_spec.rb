require "rails_helper"

describe "When visiting the new checkins page" do
  before do
    @user = create(:user)
    sign_in @user
  end

  it "form can be submitted with exiting habits" do
    habit = create(:habit, name: "Practice Typing")

    visit new_user_checkin_path(@user)

    check "Practice Typing"
    fill_in "Notes", with: "This is a note"

    click_button "Submit checkin"

    expect(page).to have_content "Practice Typing"
    expect(page).to have_content "This is a note"
    expect(page.current_path).to eq user_path(@user)
  end

  it "form can be submitted with a new habit" do
    visit new_user_checkin_path(@user)

    fill_in "New habit name", with: "Ride Bike"
    fill_in "Notes", with: "This is a note"

    click_button "Submit checkin"

    expect(page).to have_content "Ride Bike"
    expect(page).to have_content "This is a note"
    expect(page.current_path).to eq user_path(@user)
  end

  it "form displays errors when input is invalid" do
    visit new_user_checkin_path(@user)

    click_button "Submit checkin"

    expect(page).to have_content "prohibited this checkin from being saved"
  end
end
