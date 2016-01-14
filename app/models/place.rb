class Place < ActiveRecord::Base
	belongs_to :placetype
	has_and_belongs_to_many :memories
	has_and_belongs_to_many :groups

	def get_lat_lng_from_address
		locationobj = Geocoder.search(self.address)
		latlng = locationobj[0].data['geometry']['location']
		self.lat = latlng['lat']
		self.lng = latlng['lng']
		self.save
	end
	# PLACETYPES = ["Home", "Town", "Restaurant or Bar", "Areena", "Sports Hall or Stadium", "Landmark", "Countryside"]

	# def get_place_type
	# 	PLACETYPES[placetype]
	# end

	# def list_place_types
	# 	PLACETYPES.each_with_index do |placetype, i|
	# 		puts "#{i} - #{placetype}"
	# 	end
	# end



end
