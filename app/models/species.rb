class Species < ActiveRecord::Base
  has_many :pets
  validates :name, presence: true
end
