module ApplicationHelper
	
	# A list item link (li a) which appears activated when the user is actually on it's url.
	# Most commonly used on navbars.
	def nav_link(link_text, link_path)
	  class_name = "nav_link"
	  
	  #adds an "active" class if the user is currenlty on the page that is pointed by this
	  class_name += " active" if current_page?(link_path)

	  content_tag(:li, :class => class_name) do
	    link_to link_text, link_path
	  end
	end

	# A table header which is a link for sorting the table by it's column.
	# Make sure you program the logics on the table's controller (see example on Projects Controller)
	def sortable(title, column)
		if column == @column
			direction = @direction == "asc" ? "desc" : "asc"
			icon = @direction == "asc" ? "icon-caret-down" : "icon-caret-up"
			title = raw("#{title} <i class=\"#{icon}\"></i>")
		else
			direction = "asc"
		end

		link_to raw(title), params.merge(sort: column, direction: direction, page: nil)
	end

	# Helper for retrieving a neat icon list of the contents of a project. It's normally used besides the project list on a table list of accordion.
	# IMPORTANT: remember to embrace this call with a raw(), so this return will processed as HTML.
	def getContentIcons(project)
		ret = "<ul class=\"project-content-icons\">"
		if project.file?
			ret +="<li><i class=\"icon-file\"></i></li>"
		end
		if project.image?
			ret +="<li><i class=\"icon-picture\"></i></li>"
		end
		if project.link?
			ret +="<li><i class=\"icon-share-alt\"></i></li>"
		end
		ret += "</ul>"

		return ret
	end	
end
