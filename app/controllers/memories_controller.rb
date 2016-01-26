class MemoriesController < ApplicationController
  before_action :set_memory, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    if params[:search]
      @memories = Memory.where("title like ?", "%#{params[:search]}%")
    else
      @memories = Memory.all
    end
    render @memories, layout: false if request.xhr?
  end

  def show
  end

  def new
    @memory = Memory.new
  end

  def edit
  end

  def create
    @memory = Memory.new(memory_params)
    respond_to do |format|
      if @memory.save
        format.json { 
          render json: {div: render_to_string(partial: 'layouts/memory.html.erb', object: @memory, locals: {frompage: "personpage"})}
        }
      else
        format.html {render :json =>  @memory.errors.to_a, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @memory.update(memory_params)
        format.html { redirect_to @memory, notice: 'Memory was successfully updated.' }
        format.json { render :show, status: :ok, location: @memory }
      else
        format.html { render :edit }
        format.json { render json: @memory.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # binding.pry;''
    @memory.destroy
    respond_to do |format|
      format.html { redirect_to memories_url, notice: 'Memory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def rank_up
     @memory = Memory.find(params[:id])
     @memory.votes.create(user: current_user, value: 1)
     @memory.update_ranking_from_votes
     # vote = Vote.new_for_item(@memory, current_user, 1)
     if @memory.save 
       @memory.update_ranking_from_votes
       render :json =>  @memory.to_json
     else
       render :json =>  @memory.errors.to_json, status: :unprocessable_entity
     end
   end

   def rank_down

     @memory = Memory.find(params[:id])
     @memory.votes.create(user: current_user, value: -1)
     @memory.update_ranking_from_votes
     # vote = Vote.new_for_item(@memory, current_user, -1)
     if @memory.save
       @memory.update_ranking_from_votes
       render :json => @memory.to_json
     else
      render :json => @memory.errors.to_json, status: :unprocessable_entity
    end
  end

  def flag_memory
    flag = Flag.new(flag_params)
    memory = Memory.find(params[:flag][:memory_id])
    memory.add_flag
    flag.save
    memory.save
    Message.create(sender_id: current_user.id, reciever_id: memory.user.id, title: "Memory Flagged", message: "Your memory #{memory.title} has been flagged. Please ensure there is nothing offensive in this message. Admin will review any messages with a high flag count. If there's nothing offensive, this message can be ignored. \n The reason given was: \n #{flag.message}")
    render :json => flag
  end

  def list_flagged
    if (current_user != nil)  && (current_user.role == "admin")
      @memories = Memory.where("flagcount > 0")
    else
      @memories = {}
      raise "No memories are flagged, or you have no right to view this page!"
    end
  end

  def list_orphaned
    if (current_user != nil)  && (current_user.role == "admin")
      @memories = []
      Memory.all.each do |memory|
        @memories << memory if memory.count_items == 0
      end
    else
      @memories = {}
      raise "No memories are orphaned, or you have no right to view this page!"
    end

  end

  def delete_all_orphans
    if (current_user != nil)  && (current_user.role == "admin")
      Memory.all.each do |memory|
        memory.delete if memory.count_items == 0
      end
    else
      @memories = {}
      raise "No memories are orphaned, or you have no right to view this page!"
    end
    redirect_to list_orphaned_memories_path
  end

  def reset_flag_count
    @memory = Memory.find(params[:id])
    @memory.reset_flag_count
    @memory.save
    render :json =>  @memory
   end

  #  def remove_item
  #   @memory = Memory.find(params[:memory])
  #   item = Person.find(params[:person]) if params[:person]
  #   item = Pet.find(params[:pet]) if params[:pet]
  #   item = Occasion.find(params[:occasion]) if params[:occasion]
  #   item = Place.find(params[:place]) if params[:place]
  #   # binding.pry;''
  #   @memory.remove_item(item)
  #   render 'remove_item', layout: false if request.xhr?
  # end

  def remove_item
    item = @memory.send(params[:type]).find(params[:item])
    @memory.send(params[:type]).delete(item)
    @memory.save
    render :json => @memory.to_json
  end

  def additem
    # another reason for memories to be polymorphic
    # binding.pry;''
    case params[:type]

    when "people"
      person = Person.find(params[:itemid])
      @memory.people << person
      render :json => person.to_json
    when "places"
      place = Place.find(params[:itemid])
      @memory.places << place
      render :json => place.to_json
    when "pets"
      pet = Pet.find(params[:itemid])
      @memory.pets << pet
      render :json => pet.to_json
    when "occasions"
      occasion = Occasion.find(params[:itemid])
      @memory.occasions << occasion
      render :json => occasion.to_json
    end
    @memory.save

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memory
      @memory = Memory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def memory_params
      params.require(:memory).permit(:title, :story, :ranking, :user_id)
    end

    def flag_params
      params.require(:flag).permit(:memory_id, :user_id, :message)
    end
  end
