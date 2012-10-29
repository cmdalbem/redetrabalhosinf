class Project < ActiveRecord::Base
	belongs_to :person
	belongs_to :course

	validates :person, presence: true
	validates :title, presence: true
	validates :course, presence: true
	validates :barra, presence: true
end
