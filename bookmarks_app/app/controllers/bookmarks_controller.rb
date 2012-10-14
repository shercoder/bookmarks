class BookmarksController < ApplicationController

	# GET => /bookmarks
	def index
	end

	# GET => /bookmarks/:id
	def show
	end

	# GET => /bookmarks/new
	def new
	end

	# POST => /bookmarks/
	def create
		redirect_to bookmarks_url, :notice => "Bookmark created successfully!"
	end

	# GET => /bookmarks/:id/edit
	def edit
	end

	# PUT => /bookmarks/:id
	def update
		flash[:notice] = "Successfully Updated!"
    
    	redirect_to bookmark_url(params[:id])
	end

	# DELETE => /bookmarks/:id
	def destroy
	end

end