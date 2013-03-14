# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def show
  	@lastProjects = Project.order("created_at DESC").limit(5).all
  	@lastPeople = Person.order("created_at DESC").limit(5).all
  	@activities = PublicActivity::Activity.order("created_at desc").limit(10).all

  	render :action => 'show'
  end

  def about
  	render :action => 'about'
  end
end
