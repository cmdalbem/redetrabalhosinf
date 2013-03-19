class ActivitiesController < ApplicationController
  def index
	@activities = PublicActivity::Activity.order("created_at desc")
  end

  def show
  	@activities = PublicActivity::Activity.where(recipient_id: params[:id]).order("created_at desc")
  end
end
