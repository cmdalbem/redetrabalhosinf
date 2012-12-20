class CommentsController < ApplicationController
	def create
		if(user_signed_in?)
			input = params["comment"]
			c = Comment.new(input)
	      	if c.save
	      		notice = "Comentario enviado com sucesso."
	      	else
	      		notice = "Erro: seu comentario nao foi enviado."
			end
		
	      	project = Project.find(input[:project_id])
	      	respond_to do |format|
	      		format.html { redirect_to project, notice: notice }
	      	end
	    else
	      redirect_to projects_url, notice: 'Not allowed!'
	    end
	end
end