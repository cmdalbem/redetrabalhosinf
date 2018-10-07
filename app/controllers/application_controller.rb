class ApplicationController < ActionController::Base
	include PublicActivity::StoreController

	protect_from_forgery

	# Shouldn't we use method_names like this? Camel case is for classes and stuff
	def checkLogged
		if not user_signed_in?
			redirect_to new_user_session_path, alert: t('user.login_required')
			return
		end
	end

	def checkAuthorization(project)
		if not project.canBeEditedBy?(current_user)
			redirect_to root_path, alert: t('user.not_authorized')
		end
	end

	def check_admin
		if not (current_user && current_user.admin)
			not_found
		end
	end

	def not_found
		raise ActionController::RoutingError.new('Not Found')
	end

	def handleProjectsSorting(plist, column, direction)
		# Default values
		@column = (column and !column.empty?) ? column : "relevance"
		@direction = (direction and !direction.empty?) ? direction : "desc"

		# What to sort by?
		case @column
			when "title"
				plist.sort_by! {|p| p.title.downcase }
			when "barra"
				plist.sort_by! {|p| p.semester }
			# when "course"
			#   plist.sort_by! {|p| p.course.name.downcase }
			when "likes"
				plist.sort_by! {|p| p.likeCount }
			when "relevance"
				plist.sort_by! {|p| p.relevance }
			when "date"
				plist.sort_by! {|p| p.created_at }
		end

		# How is the ordering?
		if @direction == "desc"
			plist.reverse!
		end

		return plist
	end

	def handleProjectsParams
		# Course filtering
		if params[:course] and !params[:course].empty?
        	@course = Course.find(params[:course].to_i)
        	@projects = @projects.where(course_id: params[:course].to_i)
		end

		# Project search
		if params[:q] and !params[:q].empty?
    		@hasQuery = true
    		@query = params[:q]
			@projects = @projects.search(@query)
			@numResults = @projects.count
		end

		# Filter projects without images
		if params[:onlyimages] and params[:onlyimages] == "true"
			@onlyimages = true
			@projects = @projects.where("image_file_name IS NOT ?", nil)
		else
			@onlyimages = false
		end
	end

end
