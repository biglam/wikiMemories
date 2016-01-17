class ImagesController < ApplicationController

	def index
		@images = Image.all
	end

	def new
		@image = Image.new
	end

def create
    @image = Image.new(image_params)
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

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:title, :url, :ranking, :user_id, :image)
    end


end
