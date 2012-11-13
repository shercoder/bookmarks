class UsersController < ApplicationController

	# before_filters goes here
	before_filter :require_user, :except => [:new, :create]
	before_filter :correct_user, :except => [:new, :create]
	
	# GET => /users
	# def index
	# 	@users = User.all
	# end

	# GET => /users/:id
	def show
		@user = User.find_by_username(params[:id])
		@bookmarks = @user.bookmarks.all
	end

	# GET => /users/new
	def new
		@user = User.new
	end

	# POST => /users/
	def create
		@user = User.new(params[:user])
		if @user.save
			reset_session
		    session[:user_id] = @user.id
			flash[:success] = "Welcome to Clipit!"
			redirect_to @user
		else
			render "new"
		end
	end

	# GET => /users/:id/edit
	def edit
		@user = User.find_by_username(params[:id])
	end

	# PUT => /users/:id
	def update
    	@user = User.find_by_username(params[:id])

	    if @user.update_attributes(params[:user])
	       redirect_to user_url(@user), :notice => "Successfully Updated!"
	    else
	      render "edit"
	    end
	end

	# DELETE => /users/:id
	def destroy
		@user = User.find_by_username(params[:id])
    	@user.destroy
    	redirect_to users_url, :notice => "Deleted successfully!"
	end

	private
	def correct_user
		user = User.find_by_username(params[:id])
		redirect_to load_current_user, :notice => "You are not authorize to look into other user's profile!" unless load_current_user?(user)
	end
end