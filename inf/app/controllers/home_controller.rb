# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  
  def show
    # newsLimit = user_signed_in? ? 10 : 5;
    newsLimit = 5;

  	@lastProjects = Project.order("created_at DESC").limit(newsLimit).all
  	@lastPeople = Person.order("created_at DESC").limit(newsLimit+2).all
  	@globalActivities = PublicActivity::Activity.order("created_at desc").limit(newsLimit+3).all
    # @tags = Tag.order("tag_text asc").all
    @tags = Tag.all
	
    if user_signed_in?
      @myActivities = PublicActivity::Activity.where("owner_id != ? AND trackable_id IN (?)", current_user, current_user.person.project_ids).order("created_at desc").limit(20).all
      @person = current_user.person
  	end

  	respond_to do |format|
      format.html
    end
  end

  def about
  	render :action => 'about'
  end

end
