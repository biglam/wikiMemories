class LinksController < ApplicationController

  def create
      @link = Link.new(link_params)
      # binding.pry;''
      if params[:link][:person_id]
        @link.people << Person.find(params[:link][:person_id])
      end
      respond_to do |format|
        if @link.save
          # format.html { redirect_to @link, notice: 'Link was successfully created.' }
        #   format.json { render :show, status: :created, location: @link }
        format.json{
          render json: {div: render_to_string(partial: 'layouts/link.html.erb', object: @link)}
        }
        # }
        else
          format.html { render :new }
          format.json { render json: @link.errors, status: :unprocessable_entity }
        end

      end
    end

    private

    def link_params
      params.require(:link).permit(:title, :address, :user_id, :linktype_id)
    end
end
