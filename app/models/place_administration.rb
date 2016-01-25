class PlaceAdministration < ActiveRecord::Base
	belongs_to :place
	belongs_to :administrator, class_name: "User"

end
