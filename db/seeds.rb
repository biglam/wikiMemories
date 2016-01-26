# Clear database

Charity.delete_all
Flag.delete_all
Image.delete_all
Link.delete_all
Linktype.delete_all
Memory.delete_all
Message.delete_all
Occasion.delete_all
Person.delete_all
Pet.delete_all
Place.delete_all
Placetype.delete_all
Species.delete_all
User.delete_all 
Vote.delete_all

# def fill_data(modeltype)
# 	num_of_memories = rand(25)
# 	num_of_memories.times do 
# 		send(modeltype).memories << Memory.find(mem_ids.sample)
# 	end

# 	num_of_links = rand(5)
# 	num_of_links.times do 
# 		send(modeltype).links.create(title: Faker::Book.title, address: Faker::Internet.url, linktype_id: linktype_ids.sample)
# 	end

# 	num_of_admins = rand(5)
# 	num_of_admins.times do 
# 		send(modeltype).administrators << User.find(user_ids.sample) unless modeltype == "person"
# 	end 
# end

# create users
owner = User.create(email: "owner@owner.example", username: "owner", password: 'password', role: 'owner')
admin = User.create(email: "admin@admin.example", username: "admin", password: 'password', role: 'admin')
50.times do
	User.create(username: Faker::Internet.user_name, email: Faker::Internet.email, password: 'password')
end
user_ids = User.all.map { |p| p.id }

# Placetype
['Home', 'Town', 'City', 'Restaurant', 'Bar', 'Arena', 'Sports Stadium', 'Landmark', 'Countryside', 'Office'].each do |placetypename|
	Placetype.create(placetype: placetypename)
end
placetype_ids = Placetype.all.map { |p| p.id }

# Species

['Cat', 'Dog', 'Rodent', 'Bird', 'Reptile', 'Mammal', 'Other'].each do |pettype|
	Species.create(name: pettype)
end
species_ids = Species.all.map { |p| p.id }

# Charity

['Cancer Research', 'Dogs Trust', 'Cat Rescue', 'British Heart Foundation', 'Shelter'].each do |charity|
	Charity.create(name: charity)
end
charity_ids = Charity.all.map { |p| p.id }
# Linktype
['Obituary', 'Profile', 'Artical', 'Other'].each do |lt|
	Linktype.create(linktype: lt)
end
linktype_ids = Linktype.all.map { |p| p.id }
# Message
200.times do
	Message.create(sender_id: user_ids.sample, reciever_id: user_ids.sample, read: true, title: Faker::Book.title, message: Faker::Lorem.paragraph)
end

# Memory
500.times do 
	Memory.create(title: Faker::Book.title, story: Faker::Lorem.paragraph, user_id: user_ids.sample)
end
mem_ids = Memory.all.map { |p| p.id }

# Person
250.times do
	person = Person.new
	person.firstname = Faker::Name.first_name
	person.middlenames = Faker::Name.name if rand(10)>4
	person.lastname = Faker::Name.last_name
	person.charity_id = charity_ids.sample
	dob = Faker::Date.between(200.years.ago, Date.today)
	person.dob = dob
	person.died = Faker::Date.between(dob, Date.today) if rand(10) > 4
	person.place_of_birth = Faker::Address.city
	person.died_of = Faker::Company.catch_phrase
	person.save
	
	# fill_data("person")

	num_of_memories = rand(25)
	num_of_memories.times do 
		person.memories << Memory.find(mem_ids.sample)
	end

	num_of_links = rand(5)
	num_of_links.times do 
		person.links.create(title: Faker::Book.title, address: Faker::Internet.url, linktype_id: linktype_ids.sample)
	end

	num_of_admins = rand(5)
	num_of_admins.times do 
		person.adminstrators << User.find(user_ids.sample)
	end 


	num_of_images = rand(5)
	num_of_images.times do 
		person.images.create(remote_image_url: "http://lorempixel.com/500/500/people")
	end

	person.save
end
people_id_samples = Person.all.map { |p| p.id }


# Pet
250.times do
	pet = Pet.new
	pet.name = Faker::Name.name
	pet.species_id = species_ids.sample
	dob = Faker::Date.between(200.years.ago, Date.today)
	pet.dob = dob
	pet.died = Faker::Date.between(dob, Date.today) if rand(10) > 4
	pet.save

	# fill_data("pet")

	num_of_memories = rand(25)
	num_of_memories.times do 
		pet.memories << Memory.find(mem_ids.sample)
	end

	num_of_links = rand(5)
	num_of_links.times do 
		pet.links.create(title: Faker::Book.title, address: Faker::Internet.url, linktype_id: linktype_ids.sample)
	end

	num_of_admins = rand(5)
	num_of_admins.times do 
		pet.administrators << User.find(user_ids.sample)
	end 

	num_of_images = rand(5)
	num_of_images.times do 
		pet.images.create(remote_image_url: (["http://lorempixel.com/500/500/animals", "http://lorempixel.com/500/500/cats"].sample))
	end

	pet.save
end

# Place
250.times do
	place = Place.new
	place.name = Faker::Address.street_name
	place.placetype_id = placetype_ids.sample
	place.address = Faker::Address.street_address
	place.lat = Faker::Address.latitude
	place.lng = Faker::Address.longitude
	place.save

	num_of_memories = rand(25)
	num_of_memories.times do 
		place.memories << Memory.find(mem_ids.sample)
	end

	num_of_links = rand(5)
	num_of_links.times do 
		place.links.create(title: Faker::Book.title, address: Faker::Internet.url, linktype_id: linktype_ids.sample)
	end

	num_of_admins = rand(5)
	num_of_admins.times do 
		place.administrators << User.find(user_ids.sample)
	end 
	num_of_images = rand(5)
	num_of_images.times do 
		place.images.create(remote_image_url: ["http://lorempixel.com/500/500/city", "http://lorempixel.com/500/500/nature"].sample)
	end
	place.save
end

# Occasion
250.times do
	occasion = Occasion.new
	occasion.name = Faker::Address.street_name
	occasion.date = Faker::Date.between(200.years.ago, Date.today)
	occasion.time = Faker::Time.between(200.days.ago, Time.now, :all)
	occasion.save

	num_of_memories = rand(25)
	num_of_memories.times do 
		occasion.memories << Memory.find(mem_ids.sample)
	end

	num_of_links = rand(5)
	num_of_links.times do 
		occasion.links.create(title: Faker::Book.title, address: Faker::Internet.url, linktype_id: linktype_ids.sample)
	end

	num_of_admins = rand(5)
	num_of_admins.times do 
		occasion.administrators << User.find(user_ids.sample)
	end 

	num_of_images = rand(5)
	num_of_images.times do 
		occasion.images.create(remote_image_url: ["http://lorempixel.com/500/500/sport", "http://lorempixel.com/500/500/nightlife"].sample)
	end
	occasion.save
end

# Vote
1000.times do
	Memory.find(mem_ids.sample).votes.create(user_id: user_ids.sample, value: (rand(3))-1)
end
image_id_samples = Image.all.map { |p| p.id }
500.times do
	Image.find(image_id_samples.sample).votes.create(user_id: user_ids.sample, value: (rand(3))-1)
end

# Flag
200.times do 
	mem = Memory.find(mem_ids.sample)
	mem.flags.create(user_id: user_ids.sample, message: Faker::Hacker.say_something_smart)
	mem.add_flag
end

Memory.all.each do |mem|
	mem.update_ranking_from_votes unless mem.votes.count == 0
end

Image.all.each do |img|
	img.update_ranking_from_votes unless img.votes.count == 0
end