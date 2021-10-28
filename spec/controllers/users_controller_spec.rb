require "rails_helper"

RSpec.describe UsersController, type: :controller do
  context "While signed in", :aggregate_failures do
    before do
      @user = create(:user)
      sign_in @user
    end

    describe "GET show" do
      it "renders the show template with proper info" do
        habit = create(:habit)
        achieved_goal = create(:goal, achieved: true, user: @user, habit: habit, target: 1)
        unachieved_goal = create(:goal, achieved: false, user: @user, habit: habit)
        checkin = build(:checkin, user: @user)
        checkin.habits << habit
        checkin.save

        get :show, params: { id: @user.id }

        expect(response).to render_template :show
        expect(assigns(:habits)).to include(habit)
        expect(assigns(:achieved_goals)).to include(achieved_goal)
        expect(assigns(:unachieved_goals)).to include(unachieved_goal)
        expect(assigns(:checkins)).to include(checkin)
      end

      it "redirects if user does not exist" do
        get :show, params: { id: 500 }

        expect(response).to redirect_to :root
      end
    end
  end
end
