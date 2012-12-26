class HomeController < ApplicationController
  def show
  	@lastProjects = Project.order("created_at DESC").limit(5).all
  	@lastPeople = Person.order("created_at DESC").limit(5).all

  	render :action => 'show'
  end

  def about
  	render :action => 'about'
  end
end
