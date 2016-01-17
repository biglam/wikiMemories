class Image < ActiveRecord::Base
  belongs_to :user
  has_many :images_people
  has_many :people, through: :images_people
  mount_uploader :image, ImageUploader
end
