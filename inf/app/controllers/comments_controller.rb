# -*- encoding : utf-8 -*-
class CommentsController < ApplicationController

	def checkAuthorization
		if not @project.canBeEditedBy?(current_user)
	    	redirect_to root_path, alert: 'Desculpe, não tens permissão pra fazer isso.'
		end
	end

	def create
		if user_signed_in?
			input = params["comment"]
			c = Comment.new(input)
			project = Project.find(input[:project_id])
	      	if c.save
	      		# project.people.each do |p|
	      		# 	if p==current_user.person
		       #  		c.create_activity :create, owner: current_user, recipient: p.user
		       #  	end
		       #  end

		    	# FIX ME: sends the notification only for the first author of the list.
		    	c.create_activity :create, owner: current_user, recipient: project.people.first.user 

	      		notice = "Comentário enviado com sucesso."
	      	else
	      		notice = "Erro: seu comentário não foi enviado."
			end
		
	      	respond_to do |format|
	      		format.html { redirect_to project, notice: notice }
	      	end
	    else
	      redirect_to projects_url, notice: 'Desculpe, não tens permissão pra fazer isso.'
	    end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@project = @comment.project
	    @comment.destroy

	    checkAuthorization

	    redirect_to @project
	end
end