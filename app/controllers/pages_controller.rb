class PagesController < ApplicationController
  
	def admin_tools

	end

	def welcome
    @lastfive = Memory.all.order('updated_at DESC').first(5)
    @yourmems = []
    if user_signed_in?
      @yourmems = current_user.memories.order('updated_at DESC').first(5)
    end
	end
end
