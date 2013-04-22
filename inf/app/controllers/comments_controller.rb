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
	      	notice = ""
	      	if c.save
		    	c.create_activity :create, owner: current_user
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

	    checkAuthorization

	    # Finds and deletes the notification of this comment
	    PublicActivity::Activity.where(owner_id: current_user, trackable_id: @comment, key: "comment.create").destroy_all
	    @comment.destroy

	    redirect_to @project
	end
end