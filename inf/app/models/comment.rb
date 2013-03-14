class Comment < ActiveRecord::Base
	include PublicActivity::Common
	
	belongs_to :person
	belongs_to :project

	validates :text, presence: true
	validates :project_id, presence: true
	validates :person_id, presence: true
end
