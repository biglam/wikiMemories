class UsersController < ApplicationController


	def show
		@user = User.find(params[:id])
		@memories = @user.memories.paginate(:page => params[:page], :per_page => 5)
	end
end
