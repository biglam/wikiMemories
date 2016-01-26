class OccasionsController < ApplicationController
  before_action :set_occasion, only: [:show, :edit, :update, :destroy]
load_and_authorize_resource
helper_method :sort_column, :sort_direction
  # GET /occasions
  # GET /occasions.json
  def index
    if params[:search]
      @occasions_search_result = Occasion.where("name like ?", "%#{params[:search]}%").limit(5) if params[:search] < ""
    else
      @occasions = Occasion.all.order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 25)
    end
    render @occasions_search_result, layout: false if request.xhr?

  end

  # GET /occasions/1
  # GET /occasions/1.json
  def show
        @memories = @occasion.memories.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /occasions/new
  def new
    @occasion = Occasion.new(name: params[:name])
  end

  # GET /occasions/1/edit
  def edit
  end

  # POST /occasions
  # POST /occasions.json
  def create
    @occasion = Occasion.new(occasion_params)
    @occasion.administrators << current_user
    respond_to do |format|
      if @occasion.save
        format.html { redirect_to @occasion, notice: 'Occasion was successfully created.' }
        format.json { render :show, status: :created, location: @occasion }
      else
        format.html { render :new }
        format.json { render json: @occasion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /occasions/1
  # PATCH/PUT /occasions/1.json
  def update
    # binding.pry;''
    @occasion.administrators << User.find(params[:adminstrator]) if params[:adminstrator]
    respond_to do |format|
      if @occasion.update(occasion_params)
        format.html { redirect_to @occasion, notice: 'Occasion was successfully updated.' }
        format.json { render :show, status: :ok, location: @occasion }
      else
        format.html { render :edit }
        format.json { render json: @occasion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /occasions/1
  # DELETE /occasions/1.json
  def destroy
    @occasion.destroy
    respond_to do |format|
      format.html { redirect_to occasions_url, notice: 'Occasion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_administrator
      admin = User.find(params[:adminstrator])
      @occasion.administrators << admin
      @occasion.save
      render :json => admin.to_json
  end

  def remove_administrator
    admin = User.find(params[:admin])
    # person.remove_item(admin)
    @occasion.administrators.delete(admin)
    @occasion.save
    render json: admin.to_json, layout: false if request.xhr?
  end

  def slideshow
    @images = @occasion.images
  end

  def add_memory
    memory = @occasion.memories.create(title: params[:title], story: params[:story], user: current_user)
    @occasion.save
    render json: {div: render_to_string(partial: 'layouts/memory.html.erb', object: memory, locals: {frompage: "personpage"})}
  end

  def add_link
    link = @occasion.links.create(title: params[:title], address: params[:address], user: current_user, linktype_id: params[:linktype_id])
    @occasion.save
    render :json =>  link.to_json
  end

  def slideshow
    @images = @occasion.images
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_occasion
      @occasion = Occasion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def occasion_params
      params.require(:occasion).permit(:name, :date, :time)
    end

  def sort_column
    Occasion.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
