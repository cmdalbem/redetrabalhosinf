class ProjectsController < ApplicationController

  def fill_barra
    if not @project.barra.nil?
      @barra = @project.barra.split("/")
    else
      @barra = ["",""]
    end
  end


  # GET /projects
  def index
    @projects = Project.all

  end

  # GET /projects/1
  def show
    @project = Project.find(params[:id])

  end

  # GET /projects/new
  def new
    @project = Project.new

    fill_barra()

  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])

    fill_barra()

    if(user_signed_in?)
      render action: "edit"
    else
      redirect_to projects_url, notice: 'Not allowed!'
    end
  end

  # POST /projects
  def create
    p = params["project"]
    owner = current_user.person
    c = Course.where(:name => p["course"]).first
    barra = params["barra1"] + "/" + params["barra2"]

    @project = Project.new(title: p["title"], course: c, person: owner, description: p["description"], barra: barra)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Projeto criado com sucesso.' }
      else
        format.html { render action: "new" }
      end
    end

  end

  # PUT /projects/1
  def update
    p = params[:project]
    owner = current_user.person
    c = Course.where(:name => p["course"]).first
    @project = Project.find(params["id"])
    barra = params["barra1"] + "/" + params["barra2"]

    respond_to do |format|
      if @project.update_attributes(person: owner, title: p["title"], description: p["description"], course: c, barra: barra)
        format.html { redirect_to @project, notice: 'Projeto atualizado com sucesso.' }
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
    @person = current_user.person

    if not @project.likes.include?(@person)
      @project.likes.push(@person)
    end

    respond_to do |format|
      format.html { redirect_to Project }
      format.js
    end
  end

end
