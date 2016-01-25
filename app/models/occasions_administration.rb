class OccasionsAdministration < ActiveRecord::Base
	belongs_to :occasion
	belongs_to :administrator, class_name: "User"
end
