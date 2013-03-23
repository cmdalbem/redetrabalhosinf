# -*- encoding : utf-8 -*-
require 'will_paginate/array'

class ProjectsController < ApplicationController

  before_filter :checkLogged, :only => [:edit, :update, :destroy, :new, :create]

  def createUnexistingTags(tags)
    # Check if one of the entered Tags doesn't exist on the Database.
    # This is how freeTagging on TokenInput works: it will give us the a number if the recognizes
    #   that the tag entered already exists, otherwise it will give us the string of this new tag.
    tags.size.times do |i|
      # Check if it's a "FreeTag"
      if not is_number?(tags[i])
        # Make sure this tag doesn't already exist, i.e. if the user entered a custom tag before 
        #   TokenInput ended searching - that's actually a bug of tokeninput which I hope will be
        #   addressed soon.
        duplicates = Tag.where(tag_text: tags[i])
        if duplicates.empty?
          newTag = Tag.create(tag_text: tags[i])
          tags[i] = newTag.id
        else
          tags[i] = duplicates.first.id
        end
      end
    end
  end

  def sort_projects_by_column(plist, column, direction)
    
    # Default values
    @column = (column and !column.empty?) ? column : "relevance"
    @direction = (direction and !direction.empty?) ? direction : "desc"

    # What to sort by?
    case @column
      when "title"
        plist.sort_by! {|p| p.title.downcase }
      when "barra"
        plist.sort_by! {|p| p.semester }
      when "course"
        plist.sort_by! {|p| p.course.name.downcase }
      when "person"
        plist.sort_by! {|p| p.person.name.downcase }
      when "likes"
        plist.sort_by! {|p| p.likeCount }
      when "relevance"
        plist.sort_by! {|p| p.relevance }
      when "date"
        plist.sort_by! {|p| p.created_at }
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
      @projects = Project.includes(:tags).includes(:comments) # are these 'includes' needed???

      if params[:course] and !params[:course].empty?
        @course = Course.find(params[:course].to_i)
        @projects = @projects.where(course_id: params[:course].to_i)
      end

      if params[:search] and !params[:search].empty?
        @projects = @projects.search(params[:search])
      end

      @searchSize = @projects.size
    # end

    @projects = @projects.all

    # Handle sortings
    sort_projects_by_column @projects, params[:sort], params[:direction]
    
    # Do pagination
    @projects = @projects.paginate(per_page: PROJECTS_PER_PAGE, page: params[:page])

    # Handle view modes (default is LIST)
    @viewMode = :list
    if params[:view]=="list"
      @viewMode = :list
    elsif params[:view]=="thumbs"
      @viewMode = :thumbs
    end

    # @lastSort = params[:sort]

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /projects/1
  def show

    # Test if we're doing it github style
    if params[:person] && params[:project]
      user = Person.find_by_nick(params[:person])
      @project = user.projects.includes(:comments).find_by_title(params[:project]) if user
    else
      @project = Project.includes(:comments).find(params[:id])
    end

    not_found if @project.nil?

    @project.update_attributes(viewCount: @project.viewCount+1)

  end

  # GET /projects/new
  def new
    @project = Project.new

  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])

    checkAuthorization(@project)

  end

  # POST /projects
  def create
    pp = params["project"]
    owner = current_user.person
    tags = pp["tag_tokens"].split(",")
    people = pp["people"]
    people.delete_at(0) # for some reason, select2 will always give us a blank string in the first position.
    people.push(current_user.person.id)

    createUnexistingTags(tags)
    

    @project = Project.new(title: pp["title"],
      course_id: pp["course_id"],
      person: owner,
      description: pp["description"],
      semester_year: pp["semester_year"],
      semester_sem: pp["semester_sem"],
      tag_ids: tags,
      image: pp["image"],
      file: pp["file"],
      link: pp["link"],
      person_ids: people
    )

    respond_to do |format|
      if @project.save
        @project.create_activity :create, owner: current_user
        @project.people.each do |p|
          if p.user!=current_user
            @project.create_activity :addOwnership, owner: current_user, recipient: p.user
          end
        end

        if params[:commit]=="save_and_add_new"
          format.html { redirect_to new_project_url, notice: 'Projeto atualizado com sucesso.' }
        else
          format.html { redirect_to project_path(@project), notice: 'Projeto atualizado com sucesso.' }
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

    checkAuthorization(@project)

    pp = params[:project]
    
    tags = pp["tag_tokens"].split(',')
    people = pp["people"]
    people.delete_at(0) # for some reason, select2 will always give us a blank string in the first position.
    people.push(current_user.person.id)
    oldAuthors = @project.people.dup

    createUnexistingTags(tags)
    

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

    if pp["link"]!=@project.link
      @project.update_attributes(link: pp["link"], linkHitCount: 0)
    end
    
    success &&= @project.update_attributes(
          # person: @project.person,
          title: pp["title"],
          description: pp["description"],
          course_id: pp["course_id"],
          semester_year: pp["semester_year"],
          semester_sem: pp["semester_sem"],
          tag_ids: tags,
          person_ids: people) 

    respond_to do |format|
      if success
        @project.create_activity :update, owner: current_user

        @project.people.each do |p|
          if not oldAuthors.include?(p)
            @project.create_activity :addOwnership, owner: current_user, recipient: p.user
          end
        end

        oldAuthors.each do |p|
          if not @project.people.include?(p)
            @project.create_activity :removeOwnership, owner: current_user, recipient: p.user
          end
        end

        if params[:commit]=="save_and_add_new"
          format.html { redirect_to new_project_url, notice: 'Projeto atualizado com sucesso.' }
        else
          format.html { redirect_to project_path(@project), notice: 'Projeto atualizado com sucesso.' }
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
        # @project.people.each do |p|
        #   @project.create_activity :like, owner: current_user, recipient: p.user
        # end
        
        # FIX ME: sends the notification only for the first author of the list.
        @project.create_activity :like, owner: current_user, recipient: @project.people.first.user 
        @project.likes.push(@person)
        @project.update_attributes(likeCount: @project.likeCount+1)
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
        # Finds and deletes the notification of this like
        PublicActivity::Activity.where(owner_id: current_user, trackable_id: @project.id, key: "project.like").destroy_all
        @project.likes.delete(@person)
        @project.update_attributes(likeCount: @project.likeCount-1)
      end
    end
    
    respond_to do |format|
      format.js
    end
  end

  def downloadFile
    @project = Project.find(params[:id])

    if cookies["#{@project.id}_downloaded"]==nil
      @project.update_attributes(downloadCount: @project.downloadCount+1)
      cookies["#{@project.id}_downloaded"] = true
    end

    respond_to do |format|
      format.html { redirect_to @project.file.url }
    end
  end

  def clickLink
    @project = Project.find(params[:id])

    if cookies["#{@project.id}_clicked"]==nil
      @project.update_attributes(linkHitCount: @project.linkHitCount+1)
      cookies["#{@project.id}_clicked"] = true     
    end

    respond_to do |format|
      format.html { redirect_to @project.link }
    end
  end

end
