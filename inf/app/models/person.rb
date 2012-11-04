class Person < ActiveRecord::Base
	has_many :projects, :dependent => :destroy
	belongs_to :user

	#Like relationship
	has_and_belongs_to_many :likes, :foreign_key => 'person_id', :class_name => "Project"

	validates :name, presence: true, length: {minimum:4, maximum: 100}
	validates :barra, presence: true, :format => { :with => /\A[1-2][0-9][0-9][0-9]\/[0-9]\z/ }
	validates :nick, presence: true, uniqueness: true, length: {minimum:4, maximum: 50}
	validates :about, length: {maximum: 1000}

	attr_accessor :barra1, :barra2

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
