class Project < ActiveRecord::Base
	belongs_to :person
	belongs_to :course

	#Like relationship
	has_and_belongs_to_many :likes, :foreign_key => 'project_id', :class_name => "Person", :join_table => 'people_projects'

	validates :person, presence: true
	validates :title, presence: true
	validates :course, presence: true
	validates :barra, presence: true
end
