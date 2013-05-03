class ActivitiesController < ApplicationController

	before_filter :check_admin, :except => :destroy

	def index
		@activities = PublicActivity::Activity.order("created_at desc")
	end

	def destroy
		@activity = PublicActivity::Activity.find(params[:id])

		if user_signed_in? and @activity.owner == current_user
			@activity.destroy 

			respond_to do |format|
				format.html { redirect_to root_path }
				format.json { head :no_content }
			end
		else
			redirect_to root_path, alert: t('user.not_authorized')
		end
  end
	
end
