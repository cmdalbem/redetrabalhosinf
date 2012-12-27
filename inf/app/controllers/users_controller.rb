class UsersController < Devise::RegistrationsController

	def new 
		super
		
		if Rails.env.development?
			@user.skip_confirmation!
		end

		@user.build_person
	end

	def create
		super

	end
end