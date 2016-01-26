class PagesController < ApplicationController
  
	def admin_tools

	end

	def welcome
    @lastfive = Memory.all.order('updated_at DESC').first(5)
    @yourmems = []
    @topranked = Memory.all.order('ranking DESC').first(5)
    # @mosttalked = People.all.order('')
    @justadded = Person.all.order('created_at DESC').first(5)
    @anniversaries = Person.where('dob BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @anniversaries +=  Person.where('dob BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @anniversaries +=  Occasion.where('date BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    if user_signed_in?
      @yourmems = current_user.memories.order('updated_at DESC').first(5)
    end
	end

  def faq

  end

  def contact

  end
end
