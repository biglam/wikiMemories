class Link < ActiveRecord::Base
  # has_many :people
  has_many :links_people
  has_many :people, through: :links_people
  has_many :links_places
  has_many :places, through: :links_places
  has_many :links_pets
  has_many :pets, through: :links_pets
  has_many :links_occasions
  has_many :occasions, through: :links_occasions

  belongs_to :linktype
  belongs_to :user
  validates :title, presence: true
  validates :address, presence: true
  validates :user_id, presence: true
end
  