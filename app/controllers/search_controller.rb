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

  def occasion
    search do
      Occasion.where("lower(name) like ?", "%#{params[:q]}%")
    end
  end

  def all
    search do

      results = Person.where("lower(lastname) like ? OR lower(firstname) like ?", "%#{params[:q]}%", "%#{params[:q]}%" )
      results += Place.where("lower(name) like ?", "%#{params[:q]}%")
      results += Pet.where("lower(name) like ?", "%#{params[:q]}%")
      results += Occasion.where("lower(name) like ?", "%#{params[:q]}%")

      results
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
      format.json { 
        # binding.pry;''
        if params[:page] == nil
        render json: @results.first(10)
      else
        # render partial: 'return', collection: @results
        # render json: {div: render_to_string(partial: 'return', collection: @results, locals: {group: params[:group]})}
        render json: {div: render_to_string(partial: 'layouts/searchitem.html.erb', object: @results, locals: {group: params[:group]})}
      end
      }
    end
  else

# redirect_to root_url, :notice => 'No search query was specified.'
end
end

end
