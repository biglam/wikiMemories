class SearchController < ApplicationController

	def user
      @results = User.where("username like ?", "%#{params[:q]}%").limit(5)
      render :json => @results
  	end

  # def bars
  #   search do
  #     Bar.where :title => params[:q]
  #   end
  # end

  private

  def search(&block)    
    if params[:q]
    	# binding.pry;''
      # @results = yield if block_given?
      # render @results, layout: false if request.xhr?
      # respond_to do |format|
      #   format.html # resources.html.erb
      #   format.json { render json: @results }
      # end
    else

      # redirect_to root_url, :notice => 'No search query was specified.'
    end
  end

end
