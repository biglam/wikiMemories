class Group < ActiveRecord::Base

	has_and_belongs_to_many :people
	has_and_belongs_to_many :pets
	has_and_belongs_to_many :places
	has_and_belongs_to_many :occasions
	has_and_belongs_to_many :memories

end