class TagsController < ApplicationController

  before_filter :check_admin, :except => :show

  # GET /tags
  # GET /tags.json
  def index
  	if params[:q]
  		params[:q].downcase!
  		@tags = Tag.where("LOWER(tag_text) LIKE ?", params[:q]).all
  	else
      # Ordering by a many-to-many relation count: http://stackoverflow.com/questions/10957025/rails-3-order-by-count-on-has-many-through
  		@tags = Tag.joins("LEFT JOIN taggings ON tags.id = taggings.tag_id").group("tags.id").order('COUNT(tag_id) DESC').all
  	end

  	respond_to do |format|
  		format.html
  		format.json { render :json => @tags.as_json }
  	end
  end

  # GET /tags/new
  # GET /tags/new.json
  def new
    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to tags_path, notice: 'Tag was successfully created.' }
        format.json { render json: @tag, status: :created, location: @tag }
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to tags_path, notice: 'Tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def show 
    @tag = Tag.find(params[:id])
    @projects = @tag.projects.includes(:people).includes(:course)
    @numTagResults = @projects.count;

    @tags = Tag.all

    handleProjectsParams()

    @projects = @projects.all

    handleProjectsSorting @projects, params[:sort], params[:direction]

    # Do pagination
    @projects = @projects.paginate(per_page: PROJECTS_PER_PAGE, page: params[:page])

    # Default view is LIST
    @viewMode = (!params[:view] or params[:view].empty? or params[:view]=="list") ? :list : :thumbs

    respond_to do |format|
      format.html
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :no_content }
    end
  end
end
