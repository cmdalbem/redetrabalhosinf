class UsersController < Devise::RegistrationsController

	def new 
		super
		@user.build_person
	end

	def create
		super

	end
end