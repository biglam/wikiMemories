class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]
load_and_authorize_resource
  # GET /places
  # GET /places.json
  def index
    if params[:search]
      @places_search_result = Place.where("name like ?", "%#{params[:search]}%").limit(5) if params[:search] < ""
    else
      @places = Place.all.paginate(:page => params[:page], :per_page => 25)
    end
    render @places_search_result, layout: false if request.xhr?
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @memories = @place.memories.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /places/new
  def new
    @place = Place.new(name: params[:name])
  end

  # GET /places/1/edit
  def edit

  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)
    # binding.pry;''
    if !(@place.lat) || (@place.lng) 
      @place.get_lat_lng_from_address
    end
    @place.administrators << current_user
    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    # binding.pry;''
    @place.administrators << User.find(params[:adminstrator]) if params[:adminstrator]
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url, notice: 'Place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_administrator
      admin = User.find(params[:adminstrator])
      @place.administrators << admin
      @place.save
      render :json => admin.to_json
  end

  def remove_administrator
    admin = User.find(params[:admin])
    # person.remove_item(admin)
    @place.administrators.delete(admin)
    @place.save
    render json: admin.to_json, layout: false if request.xhr?
  end

  def slideshow
    @images = @place.images
  end

  def add_memory
    memory = @place.memories.create(title: params[:title], story: params[:story], user: current_user)
    @place.save
    render json: {div: render_to_string(partial: 'layouts/memory.html.erb', object: memory, locals: {frompage: "personpage"})}
  end

  def add_link
    link = @place.links.create(title: params[:title], address: params[:address], user: current_user, linktype_id: params[:linktype_id])
    @place.save
    render :json =>  link.to_json
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name, :placetype, :placetype_id, :lat, :lng, :address)
    end
end
