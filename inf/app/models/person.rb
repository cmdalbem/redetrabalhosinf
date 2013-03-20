class Person < ActiveRecord::Base
	has_many :ownerships, dependent: :destroy
	has_many :projects, through: :ownerships, dependent: :destroy
	
	belongs_to :user

	#Like relationship
	has_and_belongs_to_many :likes, :foreign_key => 'person_id', :class_name => "Project"

	validates :name, presence: true, length: {minimum:4, maximum: PERSON_NAME_MAX_LENGTH}
	validates :nick, presence: true, uniqueness: true, length: {minimum:4, maximum: PERSON_NICK_MAX_LENGTH}
	validates :about, length: {maximum: PERSON_ABOUT_MAX_LENGTH}
	validates :semester_year, allow_blank: true, :numericality => { :greater_than => 1989, :less_than_or_equal_to => Time.now.year }
	validates :semester_sem, allow_blank: true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 2 }

	
	imagePath = Rails.env.development? ? "dev/:attachment/:id/:style.:extension" : ":attachment/:id/:style.:extension"
	has_attached_file :avatar, :path => imagePath, :default_url => "https://s3.amazonaws.com/redesocialinf/user.gif", :styles => { thumb: "x18", original: "x200" }
		validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/png', 'image/gif', 'image/bmp'] 
		validates_attachment_size :avatar, :less_than => MAX_IMAGE_FILE_SIZE_MB.megabytes

	attr_reader :semester
	def semester
		semester_year.to_s + "/" + semester_sem.to_s
	end
	def semester?
		return semester_year?
	end

	def getFirstName()
		name.split(' ').first
	end

	def self.search(search)
		search.downcase!
		if search
			# Queries: http://m.onkey.org/active-record-query-interface
			where("lower(name) LIKE ? OR lower(nick) LIKE ?", "%#{search}%", "%#{search}%")
		else
			scoped
		end
	end	

	def getTotalLikes()
		sum=0
		projects.each { |p| sum += p.likes.count }
		sum
	end

	def getTotalDownloads()
		sum=0
		projects.each { |p| sum += p.downloadCount }
		sum
	end

	def to_s
		nick
	end

	# JSON formatting used for feeding the TokenInput Plugin autocomplete feature.
	def as_json()
	  { :id => self.id, :text => "#{self.name (self.nick)}" }
	end

end
