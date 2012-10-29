class Person < ActiveRecord::Base
	has_many :projects, :dependent => :destroy
	belongs_to :user

	#Like relationship
	has_and_belongs_to_many :projects

	validates :name, presence: true
	validates :nick, presence: true, uniqueness: true

end
