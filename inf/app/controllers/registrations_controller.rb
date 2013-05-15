# -*- encoding : utf-8 -*-
class RegistrationsController < Devise::RegistrationsController

	def new
		super
	end

	def create
		# super

		params[:user][:person_attributes]["nick"] = params[:user]["email"]
		params[:user]["email"] += "@inf.ufrgs.br";

		@user = User.new(params[:user])

		if Rails.env.development?
			@user.skip_confirmation!
		end
		
		if @user.save
			if Rails.env.development?
				flash[:notice] = "Conta criada com sucesso. Como estás em DEVELOPMENT, o email já foi confirmado automaticamente, e já podes logar."
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