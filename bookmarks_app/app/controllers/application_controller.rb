class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_current_user

  protected

  def load_current_user
  	if session[:user_id]
  		@current_user = User.find(session[:user_id])
  	end
  end

  def require_user
    unless load_current_user
      flash[:notice] = "You must be logged in to access this page"
      redirect_to signin_url
    end
  end
end
