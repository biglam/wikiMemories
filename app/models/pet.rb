class Pet < ActiveRecord::Base
	has_and_belongs_to_many :memories
	# has_and_belongs_to_many :groups
  has_many :group_items, :as => :groupable
  	belongs_to :species

  has_many :pets_administrations
  has_many :administrators, through: :pets_administrations
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

	def get_top_image
		self.images.order('ranking DESC')[0].image
	end

	def can_admin(user)
		if user
			list = self.administrators.map {|admin| admin.id}
			list.include?(user.id)
		end
	end

	def remove_item(item)
		# binding.pry;''
		self.administrators.delete(item) if item.class == User
		self.save
	end

end
