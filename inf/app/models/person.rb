class Person < ActiveRecord::Base
	has_many :projects, :dependent => :destroy
	belongs_to :user

	validates :name, :presence => true
	# for full email validation use: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
	#   source: http://stackoverflow.com/questions/1156601/whats-the-state-of-the-art-in-email-validation-for-rails
	validates :email, presence: true, format: { with: /\A[a-z0-9._%+-]+\z/i }

	accepts_nested_attributes_for :user

	def getEmail
		return email + "@inf.ufrgs.br"
	end

end
