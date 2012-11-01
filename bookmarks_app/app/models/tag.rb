class Tag < ActiveRecord::Base
	has_many :taggings, :dependent => :destroy
	has_many :bookmarks, :through => :taggings

	attr_accessible :name

	# setter to convert letters to lowercase before it gets saved in DB
	def name=(value)
	    write_attribute(:name, value.downcase)
	end

	# overriden methods
	def to_param
		name
	end

	#validations

	validates :name, :presence => true, :length => { :maximum => 10 }
end