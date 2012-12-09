class Course < ActiveRecord::Base
	has_many :projects

	validates :name, presence: true
	validates :code, uniqueness: true

end
