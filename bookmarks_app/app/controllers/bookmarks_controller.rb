class BookmarksController < ApplicationController

	# GET => /bookmarks
	def index
		@bookmarks = bookmark_list
	end

	# GET => /bookmarks/:id
	def show
		@bookmark = bookmark_list[params[:id].to_i]
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
		redirect_to bookmarks_url, :notice => "Bookmark deleted successfully!"
	end

	private
	def bookmark_list
		[{:type => "Article", :title => "How did they find that monkey?", :rating => "3", 
			:source => "http://www.sciencemag.org", 
			:description => "I am shocked. How did they find that monkey? 
							This is just crazy. I am going nuts. Am I going nuts? 
							I mean seriously where did he come from?",
			:tags => ["monkey", "africa", "new-species", "animal"]},
		 {:type => "Video", :title => "Wow account deleted!", :rating => "4",
		 	:source => "http://www.youtube.com", 
			:description => "That kid is going crazy because his mother deleted his WOW account!",
			:tags => ["crazy", "WOW", "video", "youtube"]},
		 {:type => "Article", :title => "Joe Biden vs Paul Ryan? Seriously?", :rating => "5",
		 	:source => "http://www.washingtonpost.com", 
			:description => "They're both dumb, they weren't even answering the questions.
							 The moderator was tired of their shit!",
			:tags => ["biden", "ryan", "election-2012", "democrats", "republicans"]}]
	end

end