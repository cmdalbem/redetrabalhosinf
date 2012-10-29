class Project < ActiveRecord::Base
	belongs_to :person
	belongs_to :course

	#Like relationship
	has_and_belongs_to_many :person

	validates :person, presence: true
	validates :title, presence: true
	validates :course, presence: true
	validates :date, presence: true
end
