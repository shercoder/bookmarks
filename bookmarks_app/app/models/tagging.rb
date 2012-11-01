class Tagging < ActiveRecord::Base
	belongs_to :bookmark
	belongs_to :tag	

	attr_accessible :bookmark_id, :tag_id
end