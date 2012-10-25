class Bookmark < ActiveRecord::Base
	attr_accessible :url, :title, :notes, :rating, :private

	belongs_to :user
end