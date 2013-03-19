# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def show
  	@lastProjects = Project.order("created_at DESC").limit(5).all
  	@lastPeople = Person.order("created_at DESC").limit(5).all
  	@globalActivities = PublicActivity::Activity.order("created_at desc").limit(8).all
	if user_signed_in?
  		@myActivities = PublicActivity::Activity.where(recipient_id: current_user).order("created_at desc").limit(15).all
  	end

  	render :action => 'show'
  end

  def about
  	render :action => 'about'
  end
end
