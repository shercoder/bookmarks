class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_current_user
  # around_filter :record_not_found

  helper_method :load_current_user, :require_user

  # include SessionsHelper

  

  # def load_current_user
  # 	@current_user = User.find(session[:user_id]) if session[:user_id]
  # end

  def load_current_user
    @current_user ||= session[:user_id] && User.find(session[:user_id])
  end

  def require_user
    unless load_current_user
      flash[:notice] = "You must be logged in to access this page"
      redirect_to signin_url
    end
  end

  def load_current_user?(user)
    user == load_current_user
  end

  # #catches the exception not found if record was not found
  # def record_not_found
  #   # yield
  #     rescue ActiveRecord::RecordNotFound
  #       redirect_to load_current_user, :flash => { :error => "Record not found." }
  # end

end
