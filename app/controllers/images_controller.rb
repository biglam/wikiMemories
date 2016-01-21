class ImagesController < ApplicationController
  load_and_authorize_resource
	def index
		@images = Image.all
	end

	def new
		@image = Image.new
	end

def create
    @image = Image.new(image_params)
    # binding.pry;''
    if params[:image][:person_id]
      @image.people << Person.find(params[:image][:person_id])
    end
    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  	@image = Image.find(params[:id])
  end

  def rank_up
     @image = Image.find(params['format'])
     vote = Vote.new
     vote.add_vote_to_item(@image, current_user, 1)
     @image.update_ranking_from_votes
     render :json =>  Image.find(params['format']).to_json
  end

  def rank_down
     @image = Image.find(params['format'])
     vote = Vote.new
     vote.add_vote_to_item(@image, current_user, -1)
     @image.update_ranking_from_votes
     render :json =>  Image.find(params['format']).to_json
  end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:title, :url, :ranking, :user_id, :image)
    end


end
