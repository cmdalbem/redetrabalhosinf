module ApplicationHelper
	def sortable(title, column)
		direction = params[:direction] == "asc" ? "desc" : "asc"
  		css_class = column == params[:sort] ? "current #{params[:direction]}" : nil
  		
		link_to title, {:sort => column, :direction => direction}, {:class => css_class}
	end
end
