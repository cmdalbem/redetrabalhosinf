class ProjectsController < ApplicationController

  def sort_projects_by_column(projectsList, column="title", direction="asc")
    # yeah, code below is kinda ugly.
    case column
      when "title"
        projectsList.sort_by! {|x| x.title }
      when "barra"
        projectsList.sort_by! {|x| x.semester }
      when "course"
        projectsList.sort_by! {|x| x.course.name }
      when "person"
        projectsList.sort_by! {|x| x.person.name }
      when "likes"
        projectsList.sort_by! {|x| x.likes.size }
      when "downloads"
        projectsList.sort_by! {|x| x.downloadCount }
      when "relevance"
        projectsList.sort_by! {|x| x.relevance }
    end

    if direction == "desc"
      projectsList.reverse!
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

    if params[:search]
      @projects = Project.search(params[:search])     
    end

    if !params[:search]
      @projects = Project.all
    end

    sort_projects_by_column @projects, params[:sort], params[:direction]

    # Default view is LIST
    @viewMode = (!params[:view] or params[:view]=="list") ? :list : :thumbs

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /projects/1
  def show
    @project = Project.includes(:comments).find(params[:id])

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

    @project = Project.new(title: pp["title"],
      course_id: pp["course_id"],
      person: owner,
      description: pp["description"],
      semester_year: pp["semester_year"],
      semester_sem: pp["semester_sem"],
      tag_ids: tags,
      image: pp["image"],
      file: pp["file"]
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
    if pp["deleteImage"] == "true"
      success = @project.update_attributes(image: nil)
    elsif pp["image"]
      success = @project.update_attributes(image: pp["image"])
    end

    if pp["deleteFile"] == "true"
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
