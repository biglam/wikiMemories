class ImagesPerson < ActiveRecord::Base

	belongs_to :image
	belongs_to :person

end
