class ProjectsController < ApplicationController
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
    p = params["project"]
    owner = current_user.person
    c = Course.where(:name => p["course"]).first
    d = Date.new(p["date(1i)"].to_i, p["date(2i)"].to_i, p["date(3i)"].to_i)

    @project = Project.new(title: p["title"], course: c, person: owner, description: p["description"], date: d)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
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
    d = Date.new(p["date(1i)"].to_i, p["date(2i)"].to_i, p["date(3i)"].to_i)
    @project = Project.find(params["id"])

    respond_to do |format|
      if @project.update_attributes(person: owner, title: p["title"], description: p["description"], course: c, date: d)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
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
