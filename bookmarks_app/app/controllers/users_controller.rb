class UsersController < ApplicationController

	# before_filters goes here
	before_filter :require_user, :except => [:new, :create]
	#layout :resolve_layout
	
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
			redirect_to user_url(@user), :notice => "Created successfully!"
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
	      # redirect_to user_url(@user.id), :notice => "Updated Dude!"
	      # redirect_to user_url(:id => @user.id), :notice => "Updated Dude!"
	      # redirect_to @user, :notice => "Successfully Updated!"
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

	def load_user
		@user = User.find_by_username(params[:id])
	end
end