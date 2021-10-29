require "rails_helper"

describe "Clicking the link on the nav bar" do
  context "While signed out" do
    it "'Sign in' takes you to the sign in page" do
      visit root_path

      click_link "Sign in"

      expect(page.current_path).to eq new_user_session_path
    end

    it "'Sign up' takes you to the sign up page" do
      visit root_path

      click_link "Sign up"

      expect(page.current_path).to eq new_user_registration_path
    end
  end

  context "While signed in" do
    before do
      @user = create(:user)
      sign_in @user
    end

    it "'Habit Builder' takes you to the root" do
      visit new_user_registration_path

      click_link "Habit Builder"

      expect(page.current_path).to eq root_path
    end

    it "'Profile' takes you to the user profile" do
      visit root_path

      click_link "Profile"

      expect(page.current_path).to eq user_path(@user)
    end

    it "'New Checkin' takes you to the new checkin form" do
      visit root_path

      click_link "New Checkin"

      expect(page.current_path).to eq new_user_checkin_path(@user)
    end

    it "'All Checkins' takes you to the checkins index" do
      visit root_path

      click_link "All Checkins"

      expect(page.current_path).to eq user_checkins_path(@user)
    end

    it "'Set a Goal' takes you to the new goal form" do
      visit root_path

      click_link "Set a Goal"

      expect(page.current_path).to eq new_user_goal_path(@user)
    end

    it "'View Goals' takes you to the root" do
      visit root_path

      click_link "View Goals"

      expect(page.current_path).to eq user_goals_path(@user)
    end

    it "'Log out' takes you to the root and logs you out" do
      visit root_path

      accept_confirm do
        click_link "Log out"
      end

      expect(page.current_path).to eq root_path
      expect(page).to have_content "Signed out successfully."
    end
  end

end
