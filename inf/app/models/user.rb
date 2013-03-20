class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :trackable, :rememberable
	devise :confirmable, :recoverable # needs Mailer

	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me

	# For using nested forms
	attr_accessible :person_attributes

	# regex source: http://stackoverflow.com/questions/1156601/whats-the-state-of-the-art-in-email-validation-for-rails
	validates :email, presence: true, uniqueness: true, format: { with: /\A[A-Za-z0-9._%+-]+@inf.ufrgs.br\z/i }
	validates :password, length: { minimum: 4 }

	# If we delete the user, the person will be deleted too
	has_one :person, :dependent => :destroy

	accepts_nested_attributes_for :person
  
	def with_person
		self.build_person unless self.person
		self
	end

	def to_s
		person.nick
	end

	# Use it for testing if the user can have access to something owned by THIS (self) user
	def authorizes?(user)
		return self==user || user.admin?
	end


end
