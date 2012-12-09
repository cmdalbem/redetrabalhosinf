class Person < ActiveRecord::Base
	has_many :projects, :dependent => :destroy
	belongs_to :user

	#Like relationship
	has_and_belongs_to_many :likes, :foreign_key => 'person_id', :class_name => "Project"

	validates :name, presence: true, length: {minimum:4, maximum: 100}
	validates :nick, presence: true, uniqueness: true, length: {minimum:4, maximum: 50}
	validates :about, length: {maximum: 1000}
	validates :semester_year, presence: true, :numericality => { :greater_than => 1989, :less_than_or_equal_to => Time.now.year }
	validates :semester_sem, presence: true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 2 }

	has_attached_file :avatar, :path => ":attachment/:id/:style.:extension", :default_url => "https://s3.amazonaws.com/redesocialinf/user.gif"

	attr_reader :semester
	def semester
		semester_year.to_s + "/" + semester_sem.to_s
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

end
