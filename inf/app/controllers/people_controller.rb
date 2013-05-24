# -*- encoding : utf-8 -*-
require 'will_paginate/array'

class PeopleController < ApplicationController
  
  before_filter :checkLogged, :only => [:edit, :update, :destroy]

  def checkAuthorization(owner)
    if !owner.authorizes?(current_user)
      redirect_to root_path, alert: 'Desculpe, não tens permissão pra fazer isso.'
    end
  end

  def sort_people_by_column(plist, column, direction)
    
    # Default values
    @column = (column and !column.empty?) ? column : "date"
    @direction = (direction and !direction.empty?) ? direction : "desc"

    # What to sort by?
    case @column
      when "name"
        plist.sort_by! {|p| p.name.downcase }
      when "email"
        plist.sort_by! {|p| p.user.email.downcase }
      when "nick"
        plist.sort_by! {|p| p.nick.downcase }
      when "projects"
        plist.sort_by! {|p| p.projects.count }
      when "date"
        plist.sort_by! {|p| p.created_at }
      when "semester"
        plist.sort_by! {|p| p.semester }
    end

    # How is the ordering?
    if @direction == "desc"
      plist.reverse!
    end
  end

  # GET /people
  def index
    # Handle searchs
    @people = Person.scoped

    if params[:q] and !params[:q].empty?
      @hasQuery = true
      @query = params[:q]
      @people = Person.search(@query)
      @numResults = @people.size
    end

    @people = @people.all

    # Handle sortings
    sort_people_by_column @people, params[:sort], params[:direction]
    
    # Do pagination
    @people = @people.paginate(per_page: PEOPLE_PER_PAGE, page: params[:page])

    # Handle view modes (default is THUMBS)
    if !params[:view]
      @viewMode = :thumbs
    else
      if params[:view]=="list"
        @viewMode = :list
      else
        @viewMode = :thumbs
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    if params[:id]
      search = Person.where(nick: params[:id])

      if search.empty?
        not_found
      else
        @person = search.first
        @projects = @person.projects.includes(:course)

        handleProjectSearch

        @projects = @projects.all

        # Handle sortings
        handleProjectsSorting @projects, params[:sort], params[:direction]

        # Do pagination
        @projects = @projects.paginate(per_page: PROJECTS_PER_PAGE_PROFILE, page: params[:page])

        # Default view is LIST
        @viewMode = (!params[:view] or params[:view].empty? or params[:view]=="list") ? :list : :thumbs

        @hideAuthors = true

        # User's activities list
        @activities = PublicActivity::Activity.where(owner_id: @person.user.id).order("created_at desc").includes(:owner).includes(:trackable).includes(:recipient)

        # Tags for personal tagcloud
        @tags = Tag.joins(:taggings).group("tags.id").where("taggings.project_id" => @person.project_ids)

        respond_to do |format|
          format.html
          format.js
        end
      end

    else
      not_found
    end

  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])

    checkAuthorization(@person.user)

  end

  # PUT /people/1
  def update
    @person = Person.find(params[:id])
    pp = params[:person]

    checkAuthorization(@person.user)

    success = true
    if params["deleteAvatar"]=="1"
      success &&= @person.update_attributes(avatar: nil)
    elsif pp["avatar"]
      success &&= @person.update_attributes(avatar: pp["avatar"])
    end

    # if success
    #   image = MiniMagick::Image.open(@person.avatar.url)
    #   image.resize "x200"
    #   AWS::S3::S3Object.store('thumb.png',  image.to_blob)
    # end
    
    success &&= @person.update_attributes(
                  name: pp["name"],
                  about: pp["about"],
                  personal_link: pp["personal_link"],
                  semester_year: pp["semester_year"],
                  semester_sem: pp["semester_sem"])

    respond_to do |format|
      if success
        format.html { redirect_to profile_path(@person.nick), notice: 'Perfil atualizado com sucesso.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /people/1
  def destroy
    @person = Person.find(params[:id])

    checkAuthorizedUser(@person.user)

    @person.destroy
  end

  def deleteAvatar

  end

end
