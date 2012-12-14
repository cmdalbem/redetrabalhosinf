class TagsController < ApplicationController

	def index
		if(params[:q])
			params[:q].downcase!
			@tags = Tag.find(:all, :conditions => ["lower(tag_text) LIKE ?", "%#{params[:q]}%"])
		else
			@tags = Tag.all
		end

		respond_to do |format|
			format.json { render :json => @tags.as_json }
		end
	end

end
