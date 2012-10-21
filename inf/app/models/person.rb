class Person < ActiveRecord::Base
	has_many :projects, :dependent => :destroy
	belongs_to :user

	validates :name, presence: true
	validates :nick, presence: true, uniqueness: true

end
