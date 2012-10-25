class User < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :username, :email

	has_many :bookmarks

	#validations goes here
end