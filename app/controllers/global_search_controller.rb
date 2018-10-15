class GlobalSearchController < ApplicationController

	MAX_PROJECTS = 7
	# MAX_COURSES = 21
	MAX_PEOPLE = 14

	def index
		@projects = @courses = @people = @tags = []

	    if params[:gq] and !params[:gq].empty?
	    	@hasQuery = true
	    	@query = params[:gq]
	    	
	    	@projects = Project.all.includes(:people)
		    @courses = Course.all
		    @people = Person.all
		    @tags = Tag.all

			# Projects search
			@projects = @projects.search(@query)
			@totalProjects = @projects.size
			@projects.sort_by{|p| p.relevance }.reverse!
			@projects = @projects[0..MAX_PROJECTS-1]

			# Courses search
			@courses = @courses.search(@query).order("name DESC")
			@totalCourses = @courses.size

			# People search
			@people = @people.search(@query).order("created_at DESC")
			@totalPeople = @people.size
			@people = @people.limit(MAX_PEOPLE)

			# Tags search
			@tags = @tags.search(@query).order("tag_text DESC")
			@totalTags = @tags.size

			@numResults = @totalProjects + @totalCourses + @totalPeople + @totalTags

			SearchLog.create(text: @query,
				    		ip: request.remote_ip,
				    		user: (user_signed_in? ? current_user : nil),
				    		resultsCount: @numResults)
	    else
	    	@numResults = @totalProjects = @totalCourses = @totalPeople = @totalTags = 0
	    	@hasQuery = false
	    	@query = ""
	    end

	end	 

end
