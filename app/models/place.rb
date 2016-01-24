class Place < ActiveRecord::Base
	belongs_to :placetype
	has_and_belongs_to_many :memories
	has_and_belongs_to_many :groups

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

end
