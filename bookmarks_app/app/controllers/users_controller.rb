class UsersController < ApplicationController

	# GET => /users
	def index
	end

	# GET => /users/:id
	def show
	end

	# GET => /users/new
	def new
	end

	# POST => /users/
	def create
		redirect_to users_url, :notice => "Created successfully!"
	end

	# GET => /users/:id/edit
	def edit
	end

	# PUT => /users/:id
	def update
		flash[:notice] = "Successfully Updated!"
    
    	redirect_to user_url(params[:id])
	end

	# DELETE => /users/:id
	def destroy
		redirect_to users_url, :notice => "Deleted successfully!"
	end

end