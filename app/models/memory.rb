class Memory < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :people
	has_and_belongs_to_many :pets
	has_and_belongs_to_many :places
end
