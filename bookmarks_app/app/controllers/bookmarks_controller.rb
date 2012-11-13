class BookmarksController < ApplicationController

	before_filter :require_user, :except => [:popular, :show]
	before_filter :correct_user, :except => [:popular, :show, :new, :create]

	helper_method :not_authorize_to_delete_or_edit
	# around_filter :record_not_found

	# GET => /bookmarks
	# def index
	# 	@bookmarks = bookmark_list
	# end

	# GET => /bookmarks/:id
	def show
		@bookmark = Bookmark.find_by_id(params[:id])
		if !@bookmark.nil?
			@bookmark.increment!(:view_count)
			@tags = @bookmark.tags.all
		else
			redirect_to load_current_user, :notice => "Record Not Found!"
		end
	end

	# GET => /bookmarks/new
	def new
		@bookmark = load_current_user.bookmarks.new
	end

	# POST => /bookmarks/
	def create
		@tags = params[:tags]
		@bookmark = load_current_user.bookmarks.new(params[:bookmark])
		@bookmark[:rating] = params[:rateme]
		# @bookmark[:user_id] = load_current_user.id

		if @bookmark.save
			# creating tags
			params[:tags].split(',').each do |tag|
				b_tag = Tag.find_or_create_by_name(tag.strip)
				tagging = Tagging.create(:bookmark_id => @bookmark[:id], :tag_id => b_tag[:id])
			end

			redirect_to bookmark_url(@bookmark), :notice => "Created successfully!"
		else
			render "new"
		end
	end

	# GET => /bookmarks/:id/edit
	def edit
		@bookmark = Bookmark.find_by_id(params[:id])
		if @bookmark.nil?
			redirect_to load_current_user, :notice => "Record Not Found!"
		end
		@tags = @bookmark.tags.all
	end

	# PUT => /bookmarks/:id
	def update
		@bookmark = Bookmark.find(params[:id])
		@bookmark[:rating] = params[:rateme]
		@bookmark[:user_id] = load_current_user.id

		old_tags = @bookmark.tags.all.map{|x| x[:name]}
		new_tags = params[:tags].split(",").map { |x| x.strip }
		diff_destroy = old_tags-new_tags
		diff_new = new_tags-old_tags

		if @bookmark.update_attributes(params[:bookmark])
			#delete tagging
			diff_destroy.each do |d|
				t = Tag.find_by_name(d)
			    tagging_to_destroy = Tagging.find_by_tag_id(t[:id])
				tagging_to_destroy.destroy
			end
			diff_new.each do |n|
				b_tag = Tag.find_or_create_by_name(n)
				tagging = Tagging.create(:bookmark_id => @bookmark[:id], :tag_id => b_tag[:id])
			end
    		redirect_to bookmark_url(params[:id])
    	end
	end

	# DELETE => /bookmarks/:id
	def destroy
		@bookmark = Bookmark.find_by_id(params[:id])
		if @bookmark.nil?
			redirect_to load_current_user, :notice => "Record Not Found!"
		end
		@bookmark.destroy
		redirect_to user_url(@bookmark.user[:username]), :notice => "Bookmark deleted successfully!"
	end

	# /bookmarks/popular
	def popular
		@popular_bookmarks = Bookmark.order("view_count DESC").limit(10)
	end

	private

	def correct_user
		redirect_to load_current_user, :notice => "You are not authorize to delete this bookmark!" unless load_current_user?(find_user)
	end

	def not_authorize_to_delete_or_edit
		#load_current_user? method is defined in application_controller
		!load_current_user?(find_user) && (find_user.id != session[:user_id])
	end

	def find_user
		bookmark = Bookmark.find_by_id(params[:id])
		if bookmark.nil? 
			redirect_to load_current_user, :notice => "Bookmark Not Found!"
		end

		user = User.find_by_id(bookmark.user_id)
		if user.nil?
			redirect_to load_current_user, :notice => "Bookmark Not Found!"
		end
		user
	end

end