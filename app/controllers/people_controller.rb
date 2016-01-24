class PeopleController < ApplicationController
  
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /people
  # GET /people.json
  def index
    if params[:search]
      @people_search_result = Person.where("lastname like ?", "%#{params[:search]}%").limit(5) if params[:search] > ""
      # @people_search_result = Person.where('lastname LIKE :search OR firstname LIKE :search OR middlenames LIKE :search', search: "params[:search]");
    else
      @people = Person.all.paginate(:page => params[:page], :per_page => 10)
    end
    render @people_search_result, layout: false if request.xhr?
    # @people = Person.all
  end

  # GET /people/1
  # GET /people/1.json
  def show
    # @image = Image.new
    @memories = @person.memories.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /people/new
  def new
    if params[:name]
      name = params[:name].split
      firstname = name.shift
      lastname = name.join(' ')
      @person = Person.new(firstname: firstname, lastname: lastname)
    else
      @person = Person.new
    end
    # binding.pry;''
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    # binding.pry;''

    @person.adminstrators << current_user
    # binding.pry;''
    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /peopleadmin.json
  # def add_admin
  #   binding.pry;''
  # end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    # binding.pry;''
    @person.adminstrators << User.find(params[:person][:adminstrator])
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def merge_records
    @person1 = Person.find(params[:person][:p1_id])
    @person2 = Person.find(params[:person][:p2_id])
    @merged = Person.new
  end

  def select_to_merge
    
  end

  def remove_administrator
   
    # person = Person.find(params[:id])
    person = Person.find(params[:person])
    admin = User.find(params[:admin])
    person.remove_item(admin)
    render admin, layout: false if request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:firstname, :middlenames, :lastname, :dob, :died, :charity_id)
    end
end
