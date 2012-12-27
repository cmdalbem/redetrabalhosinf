# -*- encoding : utf-8 -*-
class RegistrationsController < Devise::RegistrationsController

	def new
		super
	end

	def create
		# super
		# if Rails.env.development?
		# 	@user.update_attribute(:confirmed_at,Time.now)
		# 	@user.update_attribute(:active,true)
		# end

		@user = User.new(params[:user])

		if Rails.env.development?
			@user.skip_confirmation!
		end
		
		if @user.save
			if Rails.env.development?
				flash[:notice] = "Conta criada com sucesso. Como estás em Development, o email já foi confirmado automaticamente, e já podes logar."
			else
				flash[:notice] = "Dentro de minutos, você receberá um e-mail com instruções para a confirmação da tua conta."
			end
			redirect_to root_url
		else
			render :action => :new
		end
	end

	def update
		super
	end
end