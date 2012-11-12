class BookmarksController < ApplicationController

	before_filter :require_user, :except => [:popular, :show]

	# GET => /bookmarks
	# def index
	# 	@bookmarks = bookmark_list
	# end

	# GET => /bookmarks/:id
	def show
		@bookmark = Bookmark.find(params[:id])
		@bookmark.increment!(:view_count)
		@tags = @bookmark.tags.all
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
		@bookmark[:user_id] = load_current_user.id

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
		@bookmark = Bookmark.find(params[:id])
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
		@bookmark = Bookmark.find(params[:id])
		@bookmark.destroy
		redirect_to user_url(@bookmark.user[:username]), :notice => "Bookmark deleted successfully!"
	end

	# /bookmarks/popular
	def popular
		@popular_bookmarks = Bookmark.order("view_count DESC").limit(10)
	end

end