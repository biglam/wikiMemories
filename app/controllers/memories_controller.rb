class MemoriesController < ApplicationController
  before_action :set_memory, only: [:show, :edit, :update, :destroy]

  # GET /memories
  # GET /memories.json
  def index
    if params[:search]
      @memories = Memory.where("title like ?", "%#{params[:search]}%")
    else
      @memories = Memory.all
    end
    render @memories, layout: false if request.xhr?
    # @memories = Memory.all
  end

  # GET /memories/1
  # GET /memories/1.json
  def show
  end

  # GET /memories/new
  def new
    @memory = Memory.new
  end

  # GET /memories/1/edit
  def edit
  end

  # POST /memories
  # POST /memories.json
  def create
    @memory = Memory.new(memory_params)
    # binding.pry;''
    if (params[:memory][:reciever_type] != nil)
      @memory.add_associate(params[:memory][:reciever_type], params[:memory][:reciever_id])
    end
    respond_to do |format|
      if @memory.save
        format.html { redirect_to @memory, notice: 'Memory was successfully created.' }
        format.json { 
          # render :show, status: :created, location: @memory 
          render json: {div: render_to_string(partial: 'layouts/memory.html.erb', object: @memory, locals: {frompage: "personpage"})}
        }
        # format.json {render 'layouts/memory'}
      else
        format.html { render :new }
        format.json { render json: @memory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memories/1
  # PATCH/PUT /memories/1.json
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

  # DELETE /memories/1
  # DELETE /memories/1.json
  def destroy
    @memory.destroy
    respond_to do |format|
      format.html { redirect_to memories_url, notice: 'Memory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def rank_up
     Memory.find(params['format']).rank_up
     @memory = Memory.find(params['format'])
     render :json =>  Memory.find(params['format']).to_json
  end

  def rank_down
     Memory.find(params['format']).rank_down
     @memory = Memory.find(params['format'])
     render :json =>  Memory.find(params['format']).to_json
  end

  def flag_memory
    # binding.pry;''
    Memory.find(params['format']).flag_memory(params)
    render :json => current_user.flags.last
  end

  def list_flagged
    if (current_user != nil)  && (current_user.role == "admin")
      @memories = Memory.where("flagcount > 0")
    else
      @memories = {}
      raise "No memories are flagged, or you have no right to view this page!"
    end
  end

  def reset_flag_count
     Memory.find(params['format']).reset_flag_count
     # binding.pry;''
     @memory = Memory.find(params['format'])
     render :json =>  Memory.find(params['format']).to_json
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
end
