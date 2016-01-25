class LinksPet < ActiveRecord::Base
	belongs_to :link
	belongs_to :pet

end
