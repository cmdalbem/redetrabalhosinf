class LinksController < ApplicationController
	
	def show
		link = Link.find(params[:id])

		if cookies["clicked_#{link.id}"]==nil
			link.update_attribute :hits, link.hits+1
			cookies["clicked_#{link.id}"] = true     
		end

		respond_to do |format|
			format.html { redirect_to link.url }
		end
	end

end
