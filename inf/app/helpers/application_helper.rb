# -*- encoding : utf-8 -*-
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

	# Little helper for getting the absolute path for an image
	def image_url(source)
	  URI.join(root_url, image_path(source))
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
		content = javascript_tag("var coursesArray = " + raw(Course.order("name asc").all.collect {|p| {text: p.name, id: p.id, nprojects: p.projects.size} }.to_json) + ";")
		content += text_field_tag(:course, "", "data-placeholder" => options[:placeholder], class: "select2", :onchange => 'this.form.submit()')
		content
	end


	# Helper for retrieving a neat icon list of the contents of a project. It's normally used besides the project list on a table list of accordion.
	# IMPORTANT: remember to embrace this call with a raw(), so this return will processed as HTML.
	def getContentIcons(project)
		ret = "<ul class=\"project-content-icons\">"
		if project.file?
			ret +="<li><i class=\"icon-file icon-grid\"></i></li>"
		end
		if project.image?
			ret +="<li><i class=\"icon-picture icon-grid\"></i></li>"
		end
		if project.link?
			ret +="<li><i class=\"icon-link icon-grid\"></i></li>"
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

	# Easy link to project helper
	def link_to_project project
		# link_to project.title, url_to_project(project)
		link_to project.title, project_path(project)
	end
	def url_to_project project
		# person_project_path(project.person.nick, project.title)
		project_path(project)
	end

	# Easy link to user profiles
	def url_to_user user
		profile_path(user.person.nick)
	end

	# Link to the list of projects of a course
	def link_to_course course
		link_to course.name, projects_path(course: course.id)
	end

	# Thanks to: http://juixe.com/techknow/index.php/2006/07/15/acts-as-taggable-tag-cloud/
	def tag_cloud(tags, classes)
		max, min = 0, 0
		i=0
		count = []
		tags.each { |t|
			count[i] = t.projects.count
			# We ignore tags without projects
			if count[i]>0
				max = count[i] if count[i] > max
				min = count[i] if count[i] < min
			end
			i+=1
		}

		divisor = ((max - min) / classes.size) + 1

		i=0
		tags.each { |t|
			if count[i]>0
				if count[i]==min
					pos = 0
				elsif count[i]==max
					pos = classes.size-1
				else
					pos = count[i] / divisor
				end

				yield t, classes[pos]
			end
			i+=1
		}
	end

	def my_pluralize(var)
		return var==1 ? "" : "s"
	end
end
