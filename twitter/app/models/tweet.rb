class Tweet < ActiveRecord::Base
	belongs_to :person
	has_many :comments
	has_many :tweets

	validates :text, :presence =>true
	validates :person, :presence =>true
end
