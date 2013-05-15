class SearchLogsController < ApplicationController
	
	before_filter :check_admin
  
  def index
  	@logs = SearchLog.order("created_at DESC").all

  	respond_to do |format|
  		format.html
  	end
  end

  def new
    @log = SearchLog.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @log = SearchLog.find(params[:id])
  end

  def create
    @log = SearchLog.new(params[:search_log])

    respond_to do |format|
      if @log.save
        format.html { redirect_to search_logs_path }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @log = SearchLog.find(params[:id])

    respond_to do |format|
      if @log.update_attributes(params[:search_log])
        format.html { redirect_to search_logs_path }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @log = SearchLog.find(params[:id])
    @log.destroy

    respond_to do |format|
      format.html { redirect_to search_logs_path }
      format.json { head :no_content }
    end
  end
end
