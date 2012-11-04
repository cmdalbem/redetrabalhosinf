class Project < ActiveRecord::Base
	belongs_to :person
	belongs_to :course

	has_many :taggings
	has_many :tags, through: :taggings

	#Like relationship
	has_and_belongs_to_many :likes, :foreign_key => 'project_id', :class_name => "Person", :join_table => 'people_projects'

	validates :person, presence: true
	validates :title, presence: true, length: {maximum: 50}
	validates :description, length: {maximum: 1000}
	validates :course, presence: true
	validates :barra, presence: true, :format => { :with => /\A[0-9][0-9][0-9][0-9]\/[0-9]\z/ }

	attr_reader :tag_tokens
	
	def tag_tokens=(ids)
		self.tag_ids = ids.split(",")
	end


	def self.search(search)
		search.downcase!
		if search
			# http://www.definenull.com/content/rails-find-conditions
			# http://m.onkey.org/active-record-query-interface
			find(:all, :conditions => ["lower(title) LIKE ? OR lower(description) LIKE ?", "%#{search}%", "%#{search}%"])
		else
			find(:all)
		end
	end

end
