class UsersController < Devise::RegistrationsController

	def new 
		super
	end

	def create
		self.user.person = Person.new(name: "nome", email: "email")

	end
end