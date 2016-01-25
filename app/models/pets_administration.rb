class PetsAdministration < ActiveRecord::Base
	belongs_to :pet
	belongs_to :administrator, class_name: "User"
end
