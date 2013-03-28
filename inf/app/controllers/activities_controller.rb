class ActivitiesController < ApplicationController

	before_filter :check_admin

	def index
		@activities = PublicActivity::Activity.order("created_at desc")
	end

	def show
		@activities = PublicActivity::Activity.where(recipient_id: params[:id]).order("created_at desc")
	end

	def destroy
		@activity = PublicActivity::Activity.find(params[:id])
		@activity.destroy

		respond_to do |format|
			format.html { redirect_to activities_path }
			format.json { head :no_content }
		end
  end
	
end
