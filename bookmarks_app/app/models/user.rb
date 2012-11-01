class User < ActiveRecord::Base
	has_many :bookmarks, :dependent => :destroy

	attr_accessible :first_name, :last_name, :username, :email, :password

	# attr_accessor :password, :password_confirmation

	# setter to convert letters to lowercase before it gets saved in DB
	def username=(value)
	    write_attribute(:username, value.downcase)
	end

	# overriding to display username instead of user_id in path
	def to_param
		username
	end

	# validations goes here

	validates :first_name, :last_name, :username, :email, :password,
		:presence => true

	validates :first_name, :last_name,
		:format => { 
			:with => /\A[a-zA-Z]+\Z/, :message => "can only contain letters."
		},
		:length => { 
			:maximum => 30, 
			:too_long => "must be less than 30 characters."
		}

	validates :username, 
		:length => { 
			:with => /\A\w+\Z/,
			:in => 4..15, 
			:too_short => "must be atleast 6 characters long.",
			:too_long => "must be less than 15 characters long."
		},
		:uniqueness => true,
		:exclusion => { :in => ["admin", "root", "new"] }

	validates :email, :format => { 
		:with => /\A.+@.+\Z/
	}

	validates :password, :length => { :minimum => 6 }

	#validates :password_confirmation, :presence => true


end