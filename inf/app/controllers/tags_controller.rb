class TagsController < ApplicationController

	def index
		@tags = Tag.all

		respond_to do |format|
			format.json { render :json => @tags.as_json }
		end
	end

end
