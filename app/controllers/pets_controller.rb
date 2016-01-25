class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]
load_and_authorize_resource
  # GET /pets
  # GET /pets.json
  def index
    if params[:search]
      @pets_search_result = Pet.where("name like ?", "%#{params[:search]}%").limit(5) if params[:search] < ""
    else
      @pets = Pet.all.paginate(:page => params[:page], :per_page => 25)
    end
    render @pets_search_result, layout: false if request.xhr?

  end

  # GET /pets/1
  # GET /pets/1.json
  def show
        @memories = @pet.memories.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /pets/new
  def new
    @pet = Pet.new(name: params[:name], species_id: params[:species_id])
  end

  # GET /pets/1/edit
  def edit
  end

  # POST /pets
  # POST /pets.json
  def create
    @pet = Pet.new(pet_params)
    @pet.administrators << current_user
    respond_to do |format|
      if @pet.save
        format.html { redirect_to @pet, notice: 'Pet was successfully created.' }
        format.json { render :show, status: :created, location: @pet }
      else
        format.html { render :new }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pets/1
  # PATCH/PUT /pets/1.json
  def update
    @pet.administrators << User.find(params[:administrator])
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to @pet, notice: 'Pet was successfully updated.' }
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pets/1
  # DELETE /pets/1.json
  def destroy
    @pet.destroy
    respond_to do |format|
      format.html { redirect_to pets_url, notice: 'Pet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def remove_administrator
    admin = User.find(params[:admin])
    # person.remove_item(admin)
    @pet.administrators.delete(admin)
    @pet.save
    render json: admin.to_json, layout: false if request.xhr?
  end

  def slideshow
    @images = @pet.images
  end

  def add_memory
    memory = @pet.memories.create(title: params[:title], story: params[:story], user: current_user)
    @pet.save
    render json: {div: render_to_string(partial: 'layouts/memory.html.erb', object: memory, locals: {frompage: "personpage"})}
  end

  def add_link
    link = @pet.links.create(title: params[:title], address: params[:address], user: current_user)
    @pet.save
    render :json =>  link.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pet
      @pet = Pet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pet_params
      params.require(:pet).permit(:name, :dob, :died, :species_id)
    end
end
