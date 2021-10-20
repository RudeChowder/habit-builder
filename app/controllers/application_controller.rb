class ApplicationController < ActionController::Base
  def set_user
    @user = User.find_by(id: params[:user_id])
  end
end
