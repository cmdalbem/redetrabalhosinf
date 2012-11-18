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
	#validates :semester_year, presence: true, :numericality => { :greater_than => 1989, :less_than_or_equal_to => Time.now.year }
	#validates :semester_sem, presence: true, :numericality => { :greater_than => 0, :less_than => 2 }

	attr_reader :tag_tokens
	attr_writer :tag_tokens
	
	def tag_tokens=(ids)
		self.tag_ids = ids.split(",")
	end

	attr_reader :semester

	def semester
		semester_year.to_s + "/" + semester_sem.to_s
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
