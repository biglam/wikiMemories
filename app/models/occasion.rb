class Occasion < ActiveRecord::Base
	has_and_belongs_to_many :memories
	has_and_belongs_to_many :groups
end
