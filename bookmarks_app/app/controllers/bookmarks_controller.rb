class BookmarksController < ApplicationController

	before_filter :load_user, :except => [:show, :popular]

	# GET => /bookmarks
	# def index
	# 	@bookmarks = bookmark_list
	# end

	# GET => /bookmarks/:id
	def show
		@bookmark = Bookmark.find(params[:id])
		@bookmark.increment!(:view_count)
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
		@bookmark[:user_id] = params[:user_id]
		if @bookmark.save
			redirect_to bookmark_url(@bookmark), :notice => "Created successfully!"
			#redirect_to user_url(@user), :notice => "Created successfully!"
		else
			render "new" # OR render :new
		end
	end

	# GET => /bookmarks/:id/edit
	def edit
		@bookmark = Bookmark.find(params[:id])
	end

	# PUT => /bookmarks/:id
	def update
		@bookmark = Bookmark.find(params[:id])

		if @user.update_attributes(params[:bookmark]) && @user.update_attribute()
    		redirect_to bookmark_url(params[:id])
    	end
	end

	# # DELETE => /bookmarks/:id
	# def destroy
	# 	redirect_to bookmarks_url, :notice => "Bookmark deleted successfully!"
	# end

	# /bookmarks/popular
	def popular
		@popular_bookmarks = Bookmark.order("view_count DESC").limit(10)
	end

	private

	def load_user
		@user = User.find(params[:user_id])
	end

end