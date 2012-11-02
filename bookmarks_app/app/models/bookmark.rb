class Bookmark < ActiveRecord::Base
	belongs_to :user
	has_many :taggings, :dependent => :destroy
	has_many :tags, :through => :taggings
	
	attr_accessible :url, :title, :notes, :rating, :private

	def url=(value)
		if value.match(/\A((http:\/\/)|(https:\/\/)).*/)
			write_attribute(:url, value.downcase)
		else
			write_attribute(:url, ("http://"+value).downcase)
		end
	end

	validates_format_of :url, :with => URI::regexp

	validates :url, :title, :notes, :rating, :presence => true

	validates :title,
		:length => {
			:in => 5..100
		}

	validates :notes,
		:length => {
			:in => 10..300
		}

	validates :rating, 
		:numericality => {
			:only_integer => true,
			:greater_than => 0,
			:less_than_or_equal_to => 5
		}

end