require "rails_helper"

RSpec.describe GoalsController, type: :controller do

  context "While signed in", :aggregate_failures do
    before do
      @user = create(:user)
      sign_in @user
    end

    describe "GET index" do
      it "renders the index template" do
        unachieved = create(:goal, user: @user)
        achieved = create(:goal, user: @user, achieved: true)
        get :index, params: { user_id: @user.id }

        expect(response).to render_template :index
        expect(assigns[:unachieved_goals]).to eq [unachieved]
        expect(assigns[:achieved_goals]).to eq [achieved]
      end
    end

    describe "GET new" do
      it "renders the new template" do
        get :new, params: { user_id: @user.id }

        expect(response).to render_template :new
      end
    end

    describe "POST create" do
      it "creates a new Goal with valid input" do
        habit = create(:habit)

        expect do
          post :create, params: valid_params(habit).merge(user_id: @user.id)
        end.to change{Goal.count}.from(0).to(1)
        expect(response).to redirect_to @user
      end

      it "re-renders the template with invalid input" do
        post :create, params: invalid_params.merge(user_id: @user.id)

        expect(response).to render_template :new
      end
    end

    describe "DELETE destroy" do
      it "destroys a valid goal" do
        goal = create(:goal, user: @user)

        expect do
          delete :destroy, params: { user_id: @user.id, id: goal.id }
        end.to change{Goal.count}.from(1).to(0)
        expect(response).to redirect_to @user
        expect(flash[:success]).to eq "Goal successfully deleted"
      end
    end

    describe "GET edit" do
      it "renders the edit template" do
        goal = create(:goal, user: @user)
        get :edit, params: { user_id: @user.id, id: goal.id }

        expect(assigns(:goal)).to eq goal
        expect(response).to render_template :edit
      end
    end

    describe "POST update" do
      it "updates a goal" do
        old_habit = create(:habit)
        goal = create(:goal, user: @user, habit: old_habit)
        new_habit = create(:habit)

        post :update, params: valid_params(new_habit).merge(user_id: @user.id, id: goal.id)
        goal.reload

        expect(response).to redirect_to @user
        expect(goal.habit).to eq new_habit
      end

      it "re-renders form when given invalid input" do
        goal = create(:goal, user: @user)

        post :update, params: invalid_params.merge(user_id: @user.id, id: goal.id)

        expect(response).to render_template :edit
      end

      it "redirects if goal does not exist" do
        get :edit, params: { user_id: @user.id, id: 500 }

        expect(response).to redirect_to user_goals_path(@user)
      end
    end
  end

  context "While signed in as the wrong user", :aggregate_failures do
    it "redirects to root" do
      user = create(:user)
      sign_in user
      user2 = create(:user)
      get :index, params: { user_id: user2.id }

      expect(response).to redirect_to :root
      expect(flash[:warning]).to eq "You do not have permission to view that profile"
    end
  end

  def valid_params(habit)
    {
      goal: {
        user_id: @user.id,
        habit_id: habit.id,
        target: 5
      }
    }
  end

  def invalid_params
    {
      goal: {
        user_id: @user.id,
        habit_id: 1,
        target: nil
      }
    }
  end
end
