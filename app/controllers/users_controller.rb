class UsersController < ApplicationController


	# GET /user
 #  # GET /user.json
	# def index
	# 	binding.pry;''
	# if params[:search]
 #      @search_result = User.where("username like ?", "%#{params[:search]}%").limit(5) if params[:search] > ""
 #      # @people_search_result = Person.where('lastname LIKE :search OR firstname LIKE :search OR middlenames LIKE :search', search: "params[:search]");
 #    # else
 #      # @people = Person.all
 #    end
 #    render @people_search_result, layout: false if request.xhr?
	# end

	def search
		@search_result = User.where("username like ?", "%#{params[:search]}%").limit(5) if params[:search] > ""
		render @search_result, layout: false if request.xhr?
	end

	def show
		@user = User.find(params[:id])
	end
end
