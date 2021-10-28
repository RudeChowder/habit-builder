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

    describe "GET edit" do
      it "renders the edit form" do
        checkin = create(:checkin, :with_one_habit, user: @user)

        get :edit, params: { user_id: @user.id, id: checkin.id }

        expect(response).to render_template :edit
        expect(assigns(:checkin)).to eq checkin
      end
    end

    describe "POST update" do
      it "updates the checkin" do
        checkin = create(:checkin, :with_one_habit, user: @user)
        habit = create(:habit)

        post :update, params: valid_params(habit).merge(user_id: @user.id, id: checkin.id)
        checkin.reload

        expect(checkin.habits).to include habit
        expect(response).to redirect_to @user
      end

      it "re-renders edit when receiving invalid input" do
        checkin = create(:checkin, :with_one_habit, user: @user)

        post :update, params: invalid_params.merge(user_id: @user.id, id: checkin.id)

        expect(response).to render_template :edit
      end
    end

    describe "DELETE destroy" do
      it "deletes a checkin" do
        checkin = create(:checkin, :with_one_habit, user: @user)

        expect do
          delete :destroy, params: { user_id: @user.id, id: checkin.id }
        end.to change{Checkin.count}.from(1).to(0)
      end
    end

    it "redirects if checkin does not exist" do
      get :edit, params: { user_id: @user.id, id: 500 }

      expect(response).to redirect_to user_checkins_path(@user)
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
        date: nil
      }
    }
  end
end
