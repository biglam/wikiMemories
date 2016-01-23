class SearchController < ApplicationController

	def user
      # @results = User.where("lower(username) like ?", "%#{params[:q]}%".downcase).limit(5)
      search do
        User.where("lower(username) like ?", "%#{params[:q]}%".downcase)
      end
      # render :json => @results
  end

  def person
    # @results = Person.where("lower(lastname) like ? OR lower(firstname) like ?", "%#{params[:q]}%", "%#{params[:q]}%" )
    # render :json => @results
    search do
      Person.where("lower(lastname) like ? OR lower(firstname) like ?", "%#{params[:q]}%", "%#{params[:q]}%" )
    end
  end

  def new_person_suggestion
    # binding.pry;''
        search do
   Person.where("lower(firstname) like ? AND lower(middlenames) like ? AND lower(lastname) like ?", "%#{params[:q]}%".downcase, "%#{params[:middlenames]}%".downcase, "%#{params[:lastname]}%".downcase)

    end
  end


  def bars
    search do
      Memory.where :title => params[:q]
    end
  end

  private

  def search(&block)    
    if params[:q]
    	# binding.pry;''
      @results = yield if block_given?
      # render @results, layout: false if request.xhr?
      respond_to do |format|
        format.html { 
          if request.xhr?
            render @results.first(5)
          else
            render @results 
            # render :template => "person/index"
            end
            }#search.html.erb}
        format.json { render json: @results.first(5) }
      end
    else

      # redirect_to root_url, :notice => 'No search query was specified.'
    end
  end

end
