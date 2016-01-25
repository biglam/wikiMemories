class SearchController < ApplicationController

  def user
    search do
      User.where("lower(username) like ?", "%#{params[:q]}%".downcase)
    end
  end

  def person
    search do
      Person.where("lower(lastname) like ? OR lower(firstname) like ?", "%#{params[:q]}%", "%#{params[:q]}%" )
    end
  end

  def new_person_suggestion
  search do
    Person.where("lower(firstname) like ? AND lower(middlenames) like ? AND lower(lastname) like ?", "%#{params[:q]}%".downcase, "%#{params[:middlenames]}%".downcase, "%#{params[:lastname]}%".downcase)
  end
end
  
  def place
    search do
      Place.where("lower(name) like ?", "%#{params[:q]}%")
    end
  end

  def pet
    search do
      Pet.where("lower(name) like ?", "%#{params[:q]}%")
    end
  end


private

def search(&block)    
  if params[:q]
    # binding.pry;''
    @results = yield if block_given?
    respond_to do |format|
      format.html { 

        if request.xhr?
          render @results.first(5)
        else
          render @results 
        end
      }
      format.json { render json: @results.first(5) }
    end
  else

# redirect_to root_url, :notice => 'No search query was specified.'
end
end

end
