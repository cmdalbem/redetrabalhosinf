class Person < ActiveRecord::Base
	has_many :projects, :dependent => :destroy
	belongs_to :user

	#Like relationship
	has_and_belongs_to_many :likes, :foreign_key => 'person_id', :class_name => "Project"

	validates :name, presence: true, length: {minimum:4, maximum: 50}
	validates :nick, presence: true, uniqueness: true, length: {minimum:4, maximum: 30}
	validates :about, length: {maximum: PERSON_ABOUT_MAX_LENGTH}
	validates :semester_year, allow_blank: true, :numericality => { :greater_than => 1989, :less_than_or_equal_to => Time.now.year }
	validates :semester_sem, allow_blank: true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 2 }

	has_attached_file :avatar, :path => ":attachment/:id/:style.:extension", :default_url => "https://s3.amazonaws.com/redesocialinf/user.gif"

	attr_reader :semester
	def semester
		
		semester_year.to_s + "/" + semester_sem.to_s
	end

	def getFirstName()
		name.split(' ').first
	end

	def self.search(search)
		search.downcase!
		if search
			# http://www.definenull.com/content/rails-find-conditions
			# http://m.onkey.org/active-record-query-interface
			find(:all, :conditions => ["lower(name) LIKE ? OR lower(nick) LIKE ?", "%#{search}%", "%#{search}%"])
		else
			find(:all)
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

end
