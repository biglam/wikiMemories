class Occasion < ActiveRecord::Base
	has_and_belongs_to_many :memories
	# has_and_belongs_to_many :groups
	has_many :group_items, :as => :groupable

	has_many :occasions_administrations
	has_many :administrators, through: :occasions_administrations
	has_many :images, :as => :image_item
	has_many :links_occasions
	has_many :links, through: :links_occasions

  validates :name, presence: true
  validates :date, presence: true

 	def how_long_ago
 		
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
