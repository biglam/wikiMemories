class Occasion < ActiveRecord::Base
	has_and_belongs_to_many :memories
	has_and_belongs_to_many :groups

  validates :name, presence: true
  validates :date, presence: true
end
