class UsersController < ApplicationController

	# before_filter goes here

	#layout Proc.new{ ['new', 'create'].include?(action_name) ? 'landing' : 'application' }

	layout :resolve_layout
	
	# GET => /users
	def index
		@users = user_list
	end

	# GET => /users/:id
	def show
		@user = user_list[params[:id].to_i]
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

	def resolve_layout
	    case action_name
	    when "new", "create"
	      "landing"
	    else
	      "application"
	    end
	end
end