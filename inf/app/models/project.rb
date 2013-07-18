class Project < ActiveRecord::Base
	include PublicActivity::Common

	belongs_to :course

	has_many :ownerships, dependent: :destroy
	has_many :people, through: :ownerships
	
	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings
	
	has_many :comments, dependent: :destroy 

	# Like relationship
	has_and_belongs_to_many :likes, :foreign_key => 'project_id', :class_name => "Person", :join_table => 'people_projects'

	# My Favorite Projects relationship
	has_and_belongs_to_many :favorites, :foreign_key => 'project_id', :class_name => "Person", :join_table => 'people_projects_favorites'

	# Attachments
	attachmentsPath = Rails.env.development? ? "dev/projects/:id/:attachment.:extension" : "projects/:id/:attachment.:extension"

	has_attached_file :image, :path => attachmentsPath, :styles => { :original => "800x800>" }
		validates_attachment_size :image, :less_than => MAX_IMAGE_FILE_SIZE_MB.megabytes
		validates_attachment_content_type :image, :content_type=>['image/jpeg', 'image/png', 'image/gif', 'image/bmp'] 

	has_attached_file :file, :path => attachmentsPath
		validates_attachment_size :file, :less_than => MAX_FILE_SIZE_MB.megabytes

	validates :title, presence: true, length: {maximum: PROJECT_TITLE_MAX_LENGTH}, format: /^[^\/]+$/
	validates :description, length: {maximum: PROJECT_DESCRIPTION_MAX_LENGTH}
	validates :course, presence: true
	validates :semester_year, allow_blank: true, :numericality => { :greater_than_or_equal_to => MINIMUM_YEAR_ACCEPTABLE, :less_than_or_equal_to => Time.now.year }
	validates :semester_sem, allow_blank: true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 2 }

	attr_reader :tag_tokens
	attr_writer :tag_tokens
	def tag_tokens=(ids)
		self.tag_ids = ids.split(",")
	end

	attr_reader :semester
	def semester
		if semester_year? or semester_sem?
			[semester_year,semester_sem].join("/")
		else
			return ""
		end
	end

	def getSemesterString
		if not semester_sem?
			if semester_year?
				return "(#{semester_year})"
			else
				return ""
			end
		else
			if semester_year?
				return "(#{semester})"
			end
		end
	end

	attr_reader :relevance
	def relevance
		# (20*self.likeCount + 10*self.downloadCount + 10*self.linkHitCount)*100.0 / (1+self.viewCount)
		10*self.likeCount + 7*self.downloadCount + 7*self.linkHitCount + 5*self.comments.count + 1*self.viewCount
	end

	def self.search(search)
		search.downcase!
		if search
			query = []
			params = []
			
			# Creates queries for each word of the input, and then join them with ANDs.
			words = search.split(" ")
			words.size.times do |i|
				query << "(title ILIKE :w#{i} OR tags_str ILIKE :w#{i} OR description ILIKE :w#{i} OR name ILIKE :w#{i})"
				params << [:"w#{i}", "%#{words[i]}%"]
			end
			query = query.join(" AND ")

			joins(:course).where(query, Hash[params])

			# References:
			# 	Queries: http://m.onkey.org/active-record-query-interface
			# 	ActiveRecord HABTM finds with "AND": http://www.ruby-forum.com/topic/191062
			# 	Joins: http://edgeguides.rubyonrails.org/active_record_querying.html#joining-tables
			# joins(:tags).where(query).group("projects.id")#.having("count(*)>=#{words.size}")
		else
			scoped
		end
	end

	# Tests if the user has authorization to edit this project
	def canBeEditedBy?(user)
		return isAuthoredByUser?(user) || user.admin?
	end

	def isAuthoredByUser?(user)
		return people.include?(user.person)
	end

	def showControlsForUser?(user)
		return (isAuthoredByUser?(user) or canBeEditedBy?(user))
	end

end
