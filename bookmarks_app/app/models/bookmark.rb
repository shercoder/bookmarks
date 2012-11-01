class Bookmark < ActiveRecord::Base
	belongs_to :user
	has_many :taggings, :dependent => :destroy
	has_many :tags, :through => :taggings
	
	attr_accessible :url, :title, :notes, :rating, :private

	validates :url, :title, :notes, :rating, :presence => true

	validates :title,
		:length => {
			:in => 5..35
		}

	validates :notes,
		:length => {
			:in => 10..300
		}

	validates :rating, 
		:numericality => {
			:only_integer => true
		}

end