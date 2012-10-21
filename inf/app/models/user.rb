class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me, :person_attributes

	# If we delete the user, the person will be deleted too
	has_one :person, :dependent => :destroy

	accepts_nested_attributes_for :person
  
	def with_person
		self.build_person unless self.person
		self
	end

end
