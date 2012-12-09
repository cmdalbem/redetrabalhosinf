class PeopleController < ApplicationController
  
  before_filter :checkLogin, :only => [:edit, :update, :destroy]

  def checkLogin
    if not user_signed_in?
      redirect_to root_path, alert: 'Safado!'
    end
  end


  # GET /people
  def index
    if params[:search]
      @people = Person.search(params[:search])
    else
      @people = Person.all
    end

    # Default view is THUMBS
    @viewMode = (!params[:view] or params[:view]=="thumbs") ? :thumbs : :list

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /people/1
  def show
    # It's called ID because of the default routing, but we use this parameter with the user's NICK. See routes.rb for more info.
    if params[:id]
      search = Person.where(nick: params[:id])

      if(search.empty?)
        redirect_to root_path, alert: "Nao consegui encontrar #{params[:id]}."
      else
        @person = search.first
      end
    end
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  def create
    pp = params[:person];

    @person = Person.new(name: pp["name"], email: pp["email"], semester_year: pp["semester_year"], semester_sem: pp["semester_sem"], avatar: pp["avatar"])

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Perfil criado com sucesso.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /people/1
  def update
    @person = Person.find(params[:id])
    pp = params[:person]

    success = true
    if pp["deleteAvatar"]=="true"
      success &&= @person.update_attributes(avatar: nil)
    elsif pp["avatar"]
      success &&= @person.update_attributes(avatar: pp["avatar"])
    end
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
    @person.destroy
  end

  def deleteAvatar

  end

end
