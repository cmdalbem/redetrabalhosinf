class PeopleController < ApplicationController
  # GET /people
  def index
    @people = Person.all
  end

  # GET /people/1
  def show
    if params[:name]
      search = Person.where(nick: params[:name])

      if(search.empty?)
        redirect_to root_path, alert: "Couldn't find profile for #{params[:name]}"
      else
        @person = search.first
      end

    else
      @person = Person.find(params[:id])
    end
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
    if not @person.barra.nil?
      @barra = @person.barra.split("/")
    else
      @barra = ["",""]
    end

  end

  # POST /people
  def create
    p = params[:person];

    @person = Person.new(name: p["name"], email: p["email"])

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /people/1
  def update
    @person = Person.find(params[:id])
    p = params[:person]
    barra = params["barra1"] + "/" + params["barra2"]

    respond_to do |format|
      if @person.update_attributes(name: p["name"], about: p["about"], personal_link: p["personal_link"], barra: barra )
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
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
end
