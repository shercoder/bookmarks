class TagsController < ApplicationController

	def new
		@tag = Tag.new
	end

	def create
		@tag = Tag.new(params[:id])
	end
end