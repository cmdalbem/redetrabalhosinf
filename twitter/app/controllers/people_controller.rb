class PeopleController < ApplicationController
 def index
    @people = Person.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end

  def new
  	@newguy = Person.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create 
    @newguy = Person.new(params[:person])

    if @newguy.save
      redirect_to people_path, notice: 'Person was successfully created.'
    else
      redirect_to people_path, notice: 'An error has occurred.'
    end
  end

end
