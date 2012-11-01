class BookmarksController < ApplicationController

	before_filter :load_user, :except => :show

	# GET => /bookmarks
	# def index
	# 	@bookmarks = bookmark_list
	# end

	# GET => /bookmarks/:id
	def show
		@bookmark = Bookmark.find(params[:id])
	end

	# GET => /bookmarks/new
	def new
		@bookmark = Bookmark.new
	end

	# POST => /bookmarks/
	def create
		@tags = params[:tags]
		@bookmark = Bookmark.new(params[:bookmark])
		@bookmark[:rating] = params[:rateme]
		if @bookmark.save
			# redirect_to bookmark_url(@bookmark), :notice => "Created successfully!"
			redirect_to user_url(@user), :notice => "Created successfully!"
		else
			render "new" # OR render :new
		end
	end

	# # GET => /bookmarks/:id/edit
	# def edit
	# 	@bookmark = bookmark_list[(params[:id]).to_i]
	# end

	# # PUT => /bookmarks/:id
	# def update
	# 	flash[:notice] = "Successfully Updated!"
    
 #    	redirect_to bookmark_url(params[:id])
	# end

	# # DELETE => /bookmarks/:id
	# def destroy
	# 	redirect_to bookmarks_url, :notice => "Bookmark deleted successfully!"
	# end

	# private

	def load_user
		@user = User.find(params[:user_id])
	end

end