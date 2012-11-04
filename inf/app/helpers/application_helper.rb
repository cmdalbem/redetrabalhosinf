module ApplicationHelper
	
	# A li link item which appears activated when the user is actually on it's url.
	def nav_link(link_text, link_path)
	  class_name = "nav_link"
	  class_name += " active" if current_page?(link_path)

	  content_tag(:li, :class => class_name) do
	    link_to link_text, link_path
	  end
	end

	# A table header which is a link for sorting the table by it's column.
	def sortable(title, column)
		if column == params[:sort]
			direction = params[:direction] == "asc" ? "desc" : "asc"
			icon = params[:direction] == "asc" ? "icon-caret-down" : "icon-caret-up"
			title = raw("#{title} <i class=\"#{icon}\"></i>")
		else
			direction = "asc"
		end

		link_to title, {:sort => column, :direction => direction, :search => params[:search]}
	end

end
