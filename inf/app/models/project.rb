class Project < ActiveRecord::Base
	belongs_to :person
	belongs_to :course

	has_many :taggings
	has_many :tags, through: :taggings
	has_many :comments, dependent: :destroy 

	#Like relationship
	has_and_belongs_to_many :likes, :foreign_key => 'project_id', :class_name => "Person", :join_table => 'people_projects'

	# Later use:
	# 	"projects/:id/:basename.:extension"
	has_attached_file :image, :path => "projects/:id/:attachment.:extension", :styles => { :original => "500x500>" }
		validates_attachment_size :image, :less_than => MAX_IMAGE_FILE_SIZE_MB.megabytes
		validates_attachment_content_type :image, :content_type=>['image/jpeg', 'image/png', 'image/gif', 'image/bmp'] 
	has_attached_file :file, :path => "projects/:id/:attachment.:extension"
		validates_attachment_size :file, :less_than => MAX_FILE_SIZE_MB.megabytes

	validates :person, presence: true
	validates :title, presence: true, length: {maximum: 255}
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
