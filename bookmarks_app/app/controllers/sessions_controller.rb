class SessionsController < ApplicationController
	def new
	end

	def create 
		@user = User.find_by_username(params[:session][:username].downcase)
	    if @user && @user.authenticate(params[:session][:password])
	    	reset_session
		    session[:user_id] = @user.id

	    	# sign_in method is defined in sessions_helper.rb
	        # sign_in(user)

	        redirect_to user_url(@user), :notice => "Login success"
	    else
	    	flash.now[:error] = "Invalid username/password combination"
	        render :new
	    end
	end

	def destroy
		reset_session
	    # sign_out function is defined in sessions_helper.rb
	    # sign_out

	    redirect_to root_url, :notice => "logged out"
	end
end