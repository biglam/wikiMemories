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
      @image.image_item = Person.find(params[:image][:person_id])
    end
    @image.image_item = Place.find(params[:image][:place_id]) if params[:image][:place_id]
    @image.image_item = Pet.find(params[:image][:pet_id]) if params[:image][:pet_id]
    @image.image_item = Occasion.find(params[:image][:occasion_id]) if params[:image][:occasion_id]
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
     @image = Image.find(params[:id])
     @image.votes.create(user: current_user, value: 1)
     if @image.save
        @image.update_ranking_from_votes
        render :json =>  @image.to_json
      else
        render :json => @image.errors.to_json, status: :unprocessable_entity
      end
  end

  def rank_down
    @image = Image.find(params[:id])
    @image.votes.create(user: current_user, value: -1)
    if @image.save
       @image.update_ranking_from_votes
       render :json =>  @image.to_json
     else
       render :json => @image.errors.to_json, status: :unprocessable_entity
     end
  end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:title, :url, :ranking, :user_id, :image)
    end

def find_image_item
  params.each do |name, value|
    if name =~ /(.+)_id$/
      return $1.classify.constantize.find(value)
    end
  end
  nil
end

end
