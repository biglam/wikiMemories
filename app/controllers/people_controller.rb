class PeopleController < ApplicationController

  before_action :set_person, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    if params[:search]
      @people_search_result = Person.where("lastname like ?", "%#{params[:search]}%").limit(5) if params[:search] > ""
    else
      @people = Person.all.paginate(:page => params[:page], :per_page => 10)
    end
    render @people_search_result, layout: false if request.xhr?
  end

  def show
    @memories = @person.memories.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    if params[:name]
      name = params[:name].split
      firstname = name.shift
      lastname = name.join(' ')
      @person = Person.new(firstname: firstname, lastname: lastname)
    else
      @person = Person.new
    end
  end

  def edit
  end

  def create
    @person = Person.new(person_params)

    @person.adminstrators << current_user
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

  def update
    @person.adminstrators << User.find(params[:adminstrator])
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


  def remove_administrator
    # binding.pry;''
    # person = Person.find(params[:person])
    admin = User.find(params[:admin])
    # person.remove_item(admin)
    @person.adminstrators.delete(admin)
    @person.save
    render json: admin.to_json, layout: false if request.xhr?
  end

  def slideshow
    @images = @person.images
  end

 def add_memory
    memory = @person.memories.create(title: params[:title], story: params[:story], user: current_user)
    @person.save
    render json: {div: render_to_string(partial: 'layouts/memory.html.erb', object: memory, locals: {frompage: "personpage"})}
  end

  def add_link
    link = @person.links.create(title: params[:title], address: params[:address], user: current_user, linktype_id: params[:linktype_id])
    @person.save
    render :json =>  link.to_json
  end

  private
  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:firstname, :middlenames, :lastname, :dob, :died, :charity_id, :place_of_birth, :brief_description)
  end
end
