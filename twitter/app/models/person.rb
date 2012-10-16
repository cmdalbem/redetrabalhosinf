class Person < ActiveRecord::Base
	has_many :tweets, :dependent => :destroy
	has_many :comments

	validates :name, :presence => true
end
