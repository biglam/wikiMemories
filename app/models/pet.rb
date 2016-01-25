class Pet < ActiveRecord::Base
	has_and_belongs_to_many :memories
	has_and_belongs_to_many :groups
  	belongs_to :species

  	has_many :pet_administrations
  	has_many :administrators, through: :pet_administrations
  	has_many :images, :as => :image_item
  	has_many :links_pets
  	has_many :links, through: :links_pets

  	validates :name, presence: true

	def age
		if died == nil
 			from = Time.now.utc.to_date
 		else 
 			from = died
 		end
  		from.year - dob.year - (dob.to_date.change(:year => from.year) > from ? 1 : 0)
	end

end
