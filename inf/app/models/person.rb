class Person < ActiveRecord::Base
	has_many :projects, :dependent => :destroy
	belongs_to :user

	#Like relationship
	has_and_belongs_to_many :likes, :foreign_key => 'person_id', :class_name => "Project"

	validates :name, presence: true, length: {minimum:4, maximum: 100}
	validates :barra, presence: true
	validates :nick, presence: true, uniqueness: true, length: {minimum:4, maximum: 50}
	validates :about, length: {maximum: 1000}

	def self.search(search)
		search.downcase!
		if search
			find(:all, :conditions => ["lower(name) LIKE ? OR lower(nick) LIKE ?", "%#{search}%", "%#{search}%"])
		else
			find(:all)
		end
	end
end
