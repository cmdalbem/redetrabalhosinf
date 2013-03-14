# -*- encoding : utf-8 -*-
class CommentsController < ApplicationController

	def checkAuthorization(owner)
		if !owner.authorizes?(current_user)
	    	redirect_to root_path, alert: 'Desculpe, não tens permissão pra fazer isso.'
		end
	end

	def create
		if user_signed_in?
			input = params["comment"]
			c = Comment.new(input)
	      	if c.save
	      		c.create_activity :create, owner: current_user

	      		notice = "Comentário enviado com sucesso."
	      	else
	      		notice = "Erro: seu comentário não foi enviado."
			end
		
	      	project = Project.find(input[:project_id])
	      	respond_to do |format|
	      		format.html { redirect_to project, notice: notice }
	      	end
	    else
	      redirect_to projects_url, notice: 'Desculpe, não tens permissão pra fazer isso.!'
	    end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@project = @comment.project
	    @comment.destroy

	    checkAuthorization(@project.person.user)

	    redirect_to @project
	end
end