# -*- encoding : utf-8 -*-
require 'will_paginate/array'

class HomeController < ApplicationController

  def listRecommendedActions
    actions = {}
    @numSuggestions = 0
    actions[:addProjects] = actions[:addAvatar] = actions[:likeProjects] = actions[:tagProjects] = false

    # Person without projects
    if @person.projects.empty?
      actions[:addProjects] = true
      @numSuggestions += 1
    end

    # Person without Avatar
    if not @person.avatar?
      actions[:addAvatar] = true
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

  	@lastProjects = Project.order("created_at DESC").limit(newsLimit).all
  	@lastPeople = Person.order("created_at DESC").limit(newsLimit+2).all
  	@globalActivities = PublicActivity::Activity.order("created_at desc").limit(newsLimit+3).all
    # @tags = Tag.order("tag_text asc").all
    @tags = Tag.all.shuffle
	
    if user_signed_in?
      @person = current_user.person

      @myActivities = PublicActivity::Activity.where("owner_id != ? AND trackable_id IN (?)", current_user, current_user.person.project_ids).order("created_at desc")
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
