module ApplicationHelper

	# A list item link (li a) which appears activated when the user is actually on it's url.
	# Most commonly used on navbars.
	def nav_link(link_text, link_path, activable=true)
	  class_name = "nav_link"
	  
	  # Adds an "active" class if the user is currenlty on the page that is pointed by this
	  if activable
	  	class_name += " active" if current_page?(link_path)
	  end

	  content_tag(:li, :class => class_name) do
	    link_to link_text, link_path
	  end
	end

	def nav_icon(link_text, icon_class)
		content_tag(:i, '', :class => icon_class) + " " + link_text
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

	def courseSelector(options)
		# select_tag :course,
		# 			# options_for_select(Course.order("name asc").all.collect {|p| [("<div class=\"" + (p.projects.size==0 ? "muted" : "") + "\">#{p.name} <span class=\"pull-right\">#{p.projects.size}</span></div>"), p.id] }),
		# 			:include_blank => true,
		# 			"data-placeholder" => options[:placeholder],
		# 			class: "select2",
		# 			:onchange => 'this.form.submit()'
		content = javascript_tag("var select2Array = " + raw(Course.order("name asc").all.collect {|p| {text: p.name, id: p.id, nprojects: p.projects.size} }.to_json) + ";")
		content += text_field_tag(:course, "", "data-placeholder" => options[:placeholder], class: "select2", :onchange => 'this.form.submit()')
		content
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
			ret +="<li><i class=\"icon-external-link\"></i></li>"
		end
		ret += "</ul>"

		return ret
	end

	# Helper for retrieving neat icons for displaying the various popularity stats for a project, i.e. Likes, Downloads, Link Hits, Comments and Views.
	# IMPORTANT: remember to embrace this call with a raw(), so this return will processed as HTML.
	def printProjectPopularityStats(project, separator="|")
		ret = "<div class=\"icons\">"
	    hasAny = false

	    if project.likeCount!=0
	    	ret += "<i class=\"icon-thumbs-up\"></i> #{project.likeCount}"
			hasAny = true
		end

		# if project.downloadCount + project.linkHitCount != 0
		# 	if hasAny
		# 		ret += "<span class=\"muted\"> #{separator} </span>"
		# 	else
		# 		hasAny = true
		# 	end

		# 	ret += "<i class=\"icon-download\"></i> #{(project.downloadCount+project.linkHitCount)}"
		# end

		if project.comments.count!=0
			if hasAny
				ret += "<span class=\"muted\"> #{separator} </span>"
			else
				hasAny = true
			end

			ret += "<i class=\"icon-comments\"></i> #{project.comments.count}"
		end

		if project.viewCount!=0
			if hasAny
				ret += "<span class=\"muted\"> #{separator} </span>"
			else
				hasAny = true
			end

			ret += "<i class=\"icon-eye-open\"></i> #{project.viewCount}"
		end

	    ret += "</div>"

	    return ret
	end

	# Creates the github style links using the Rails Route Helper
	def link_to_project project
		# link_to project.title, url_to_project(project)
		link_to project.title, project_path(project)
	end
	def url_to_project project
		# person_project_path(project.person.nick, project.title)
		project_path(project)
	end

	# Link to the projects list with a search for this tag
	def link_to_tag tag
		link_to tag.tag_text, projects_path(search: tag.tag_text)
	end

	# Thanks to: http://juixe.com/techknow/index.php/2006/07/15/acts-as-taggable-tag-cloud/
	def tag_cloud(tags, classes)
		max, min = 0, 0
		i=0
		count = []
		tags.each { |t|
			count[i] = t.projects.count
			max = count[i] if count[i] > max
			min = count[i] if count[i] < min
			i+=1
		}

		divisor = ((max - min) / classes.size) + 1

		i=0
		tags.each { |t|
			yield t.tag_text, classes[(count[i] / divisor)]
			i+=1
		}
	end
end
