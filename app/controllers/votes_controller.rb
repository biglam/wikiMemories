class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end


  def find_votable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
