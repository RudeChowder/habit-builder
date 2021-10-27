require "rails_helper"

RSpec.describe CheckinsController, type: :controller do

  context "While signed in", :aggregate_failures do
    before do
      @user = create(:user)
      sign_in @user
    end

    describe "GET index" do
      it "renders the index template" do
        create(:checkin, :with_one_habit, user: @user)

        get :index, params: { user_id: @user.id }

        expect(response).to render_template :index
      end
    end

    describe "GET new" do
      it "renders the new template" do
        get :new, params: { user_id: @user.id }

        expect(response).to render_template :new
      end
    end

    describe "POST create" do
      it "creates a new checkin with valid input" do
        habit = create(:habit)

        expect do
          post :create, params: valid_params(habit).merge(user_id: @user.id)
        end.to change{Checkin.count}.from(0).to(1)
        expect(response).to redirect_to @user
      end

      it "re-renders the form with invalid input" do
        post :create, params: invalid_params.merge(user_id: @user.id)

        expect(response).to render_template :new
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
      checkin: {
        user_id: @user.id,
        habit_ids: [habit.id],
        date: Date.today,
        notes: "Cool",
      }
    }
  end

  def invalid_params
    {
      checkin: {
        user_id: @user.id,
        notes: "Cool",
      }
    }
  end
end
