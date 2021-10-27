require "rails_helper"

RSpec.describe HabitsController, type: :controller do

  describe "GET show" do
    it "renders the habit show template if the user has that habit", :aggregate_failures do
      user = create(:user)
      habit = create(:habit)
      create_checkin_for_user_and_habit(user, habit)
      sign_in user

      get :show, params: { user_id: user.id, id: habit.id }

      expect(response).to render_template :show
      expect(assigns(:checkin_count)).to eq 1
    end

    it "redirects to user profile if user does not have that habit" do
      user = create(:user)
      habit = create(:habit)
      sign_in user

      get :show, params: { user_id: user.id, id: habit.id }

      expect(response).to redirect_to user
    end

    it "redirects to user profile if habit cannot be found", :aggregate_failures do
      user = create(:user)
      habit = create(:habit)
      create_checkin_for_user_and_habit(user, habit)
      sign_in user

      get :show, params: { user_id: user.id, id: habit.id + 1 }

      expect(response).to redirect_to user
      expect(flash[:warning]).to eq "Sorry, I could not find that habit"
    end
  end

  def create_checkin_for_user_and_habit(user, habit)
    checkin = build(:checkin, user: user)
    checkin.habits << habit
    checkin.save
  end
end
