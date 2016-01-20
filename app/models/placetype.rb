class Placetype < ActiveRecord::Base
	has_many :places
  validates :placetype, presence: true
end
