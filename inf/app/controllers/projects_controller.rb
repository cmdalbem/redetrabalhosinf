class ProjectsController < ApplicationController

  def sort_projects_by_column(plist, column, direction)
    
    # Default values
    @column = column ? column : "relevance"
    @direction = direction ? direction : "desc"

    # What to sort by?
    case @column
      when "title"
        plist.sort_by! {|p| p.title }
      when "barra"
        plist.sort_by! {|p| p.semester }
      when "course"
        plist.sort_by! {|p| p.course.name }
      when "person"
        plist.sort_by! {|p| p.person.name }
      when "likes"
        plist.sort_by! {|p| p.likes.size }
      when "downloads"
        plist.sort_by! {|p| p.downloadCount }
      when "relevance"
        plist.sort_by! {|p| p.relevance }
    end

    # How is the ordering?
    if @direction == "desc"
      plist.reverse!
    end
  end


  # GET /projects
  def index
    # if params[:person]
    #   personSearch = Person.where(nick: params[:person])
    #   if(personSearch.empty?)
    #     redirect_to root_path, alert: "Nao consegui encontrar #{params[:id]}."
    #     return
    #   else
    #     @projects = personSearch.first.projects
    #   end
    # end

    # if params[:sort] == @lastSort
      # Handle searchs
      if params[:search]
        @projects = Project.search(params[:search])
      elsif params[:course]
        @course = Course.find(params[:course][:id].to_i)
        @projects = @course.projects
      else
        @projects = Project.all
      end
    # end

    # Handle sortings
    sort_projects_by_column @projects, params[:sort], params[:direction]

    # Handle view modes (default is LIST)
    if !params[:view]
      @viewMode = :list
    else
      if params[:view]=="list"
        @viewMode = :list
      else
        @viewMode = :thumbs
      end
    end

    # @lastSort = params[:sort]

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /projects/1
  def show
    @project = Project.includes(:comments).find(params[:id])

    @project.update_attributes(viewCount: @project.viewCount+1)

  end

  # GET /projects/new
  def new
    @project = Project.new

  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])

    if(user_signed_in?)
      render action: "edit"
    else
      redirect_to projects_url, notice: 'Not allowed!'
    end
  end

  # POST /projects
  def create
    pp = params["project"]
    owner = current_user.person
    tags = pp["tag_tokens"].split(",")

    # Check if one of the entered Tags doesn't exist on the Database.
    tags.size.times do |i|
      if not is_number?(tags[i])
        newTag = Tag.create(tag_text: tags[i])
        tags[i] = newTag.id
      end
    end

    @project = Project.new(title: pp["title"],
      course_id: pp["course_id"],
      person: owner,
      description: pp["description"],
      semester_year: pp["semester_year"],
      semester_sem: pp["semester_sem"],
      tag_ids: tags,
      image: pp["image"],
      file: pp["file"],
      link: pp["link"]
    )

    respond_to do |format|
      if @project.save
        if params[:commit]=="Salvar e adicionar outro"
          format.html { redirect_to new_project_url, notice: 'Projeto atualizado com sucesso.' }
        else
          format.html { redirect_to @project, notice: 'Projeto atualizado com sucesso.' }
        end
      else
        format.html { render action: "new" }
      end
    end

  end

  def is_number?(object)
    Float(object) != nil rescue false
  end

  # PUT /projects/1
  def update
    @project = Project.find(params["id"])

    pp = params[:project]
    owner = current_user.person
    tags = pp["tag_tokens"].split(",")

    # Check if one of the entered Tags doesn't exist on the Database.
    tags.size.times do |i|
      if not is_number?(tags[i])
        newTag = Tag.create(tag_text: tags[i])
        tags[i] = newTag.id
      end
    end

    success = true
    if params["deleteImage"] == "1"
      success = @project.update_attributes(image: nil)
    elsif pp["image"]
      success = @project.update_attributes(image: pp["image"])
    end

    if params["deleteFile"] == "1"
      success &&= @project.update_attributes(file: nil, downloadCount: 0)
    elsif pp["file"]
      success &&= @project.update_attributes(file: pp["file"], downloadCount: 0)
    end
    
    success &&= @project.update_attributes(person: owner,
          title: pp["title"],
          description: pp["description"],
          course_id: pp["course_id"],
          semester_year: pp["semester_year"],
          semester_sem: pp["semester_sem"],
          link: pp["link"],
          tag_ids: tags) 

    respond_to do |format|
      if success
        if params[:commit]=="Salvar e adicionar outro"
          format.html { redirect_to new_project_url, notice: 'Projeto atualizado com sucesso.' }
        else
          format.html { redirect_to @project, notice: 'Projeto atualizado com sucesso.' }
        end
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /projects/1
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.js
    end
  end

  def like
    @project = Project.find(params[:id])
    if @project
      @person = current_user.person
      if not @project.likes.include?(@person)
        @project.likes.push(@person)
      end
    end

    respond_to do |format|
      format.html { redirect_to Project }
      format.js
    end
  end

  def unlike
    @project = Project.find(params[:id])
    if @project
      @person = current_user.person
      if @project.likes.include?(@person)
        @project.likes.delete(@person)
      end
    end
    
    respond_to do |format|
      format.html { redirect_to Project }
      format.js
    end
  end

  def downloadFile
    @project = Project.find(params[:id])

    @project.update_attributes(downloadCount: @project.downloadCount+1)

    respond_to do |format|
      format.html { redirect_to @project.file.url }
    end
  end

end
