# -*- encoding : utf-8 -*-
require 'will_paginate/array'

class HomeController < ApplicationController

  def listRecommendedActions
    actions = {}
    @numSuggestions = 0
    actions[:addProjects] = actions[:incompleteProfile] = actions[:likeProjects] = actions[:tagProjects] = false

    # Person without projects
    if @person.projects.empty?
      actions[:addProjects] = true
      @numSuggestions += 1
    end

    # Person with incomplete profile
    totalProfileDetails = 5
    missingProfileDetails = 0
    if not @person.avatar?
      missingProfileDetails += 1
    end
    if @person.about.blank?
      missingProfileDetails += 1
    end
    if not @person.semester?
      missingProfileDetails += 1
    end
    if @person.personal_link.blank?
      missingProfileDetails += 1
    end
    if missingProfileDetails > 0
      actions[:incompleteProfile] = true
      @profileCompletePerc = 100*(totalProfileDetails-missingProfileDetails)/totalProfileDetails
      @numSuggestions += 1
    end

    # Didn't like anything yet
    if @person.likes.empty?
      actions[:likeProjects] = true
      @numSuggestions += 1
    end

    # There are projects without tags
    @untaggedProjects = []
    @person.projects.each do |p|
      if p.tags.empty?
        @untaggedProjects << p
      end
    end
    if not @untaggedProjects.empty?
      actions[:tagProjects] = true
      @numSuggestions += 1
    end

    return actions
  end

  
  def show
    newsLimit = user_signed_in? ? 10 : 5;
    activitiesPerPage = 10
    # newsLimit = 5;

  	@lastProjects = Project.order("created_at DESC").limit(newsLimit).includes(:people).includes(:course).all
  	@lastPeople = Person.order("created_at DESC").limit(newsLimit+2).all
  	@globalActivities = PublicActivity::Activity.order("created_at desc").limit(newsLimit+3)
    @globalActivities = @globalActivities.includes(:owner).includes(:trackable).all
    # @tags = Tag.order("tag_text asc").all
    @tags = Tag.all.shuffle

    @totalCourses = Course.joins(:projects).group("courses.id").having("count(courses.id) > 0").count.length
    @totalProjects = Project.count
    @totalUsers = User.count
    @totalTags = Tag.count
	
    if user_signed_in?
      @person = current_user.person

      @myActivities = PublicActivity::Activity.where("owner_id != ? AND trackable_id IN (?)", current_user, current_user.person.project_ids).order("created_at desc")
      @myActivities = @myActivities.includes(:owner).includes(:trackable)
      @myActivities = @myActivities.paginate(per_page: activitiesPerPage, page: params[:page])
      @myActivities = @myActivities.all

      @recommendedActions = listRecommendedActions()
  	end

  	respond_to do |format|
      format.html
    end
  end

  def sobre
  	
  end

end
