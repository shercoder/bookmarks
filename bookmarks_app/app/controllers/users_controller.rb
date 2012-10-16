class UsersController < ApplicationController

	# GET => /users
	def index
		@users = user_list
	end

	# GET => /users/:id
	def show
		@user = user_list[params[:id].to_i]
		if @users == nil
			redirect_to "404.html"
		end
	end

	# GET => /users/new
	def new
		@user = {}
	end

	# POST => /users/
	def create
		redirect_to users_url, :notice => "Created successfully!"
	end

	# GET => /users/:id/edit
	def edit
		@user = user_list[(params[:id]).to_i]
		if @user == nil
			render :status => 404
		end
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

	private 

	def user_list
		[{:username => "SherCoder", :first_name => "Pardeep", 
			:last_name => "Singh", :user_image => "mypic.jpg",
			:email => "shercoder@shercoder.com"},
		 {:username => "BidenTheRaven", :first_name => "Joe", 
			:last_name => "Biden", :user_image => "mypic.jpg",
			:email => "biden@theraven.com"}]
	end
end