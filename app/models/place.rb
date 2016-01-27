class Place < ActiveRecord::Base
	belongs_to :placetype
	has_and_belongs_to_many :memories
	has_many :group_items, :as => :groupable
	has_many :place_administrations
	has_many :administrators, through: :place_administrations
	has_many :images, :as => :image_item
	has_many :links_places
	has_many :links, through: :links_places
	validates :name, presence: true

	def get_lat_lng_from_address
		locationobj = Geocoder.search(self.address)
		if locationobj != []
			latlng = locationobj[0].data['geometry']['location']
			self.lat = latlng['lat']
			self.lng = latlng['lng']
			self.save
		end
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
