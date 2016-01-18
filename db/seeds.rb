# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# User.delete_all
# Person.delete_all
# Memory.delete_all
# Place.delete_all
# Placetype.delete_all
# Pet.delete_all
# Charity.delete_all
# Species.delete_all


admin = User.create(email: "admin@admin.example", username: "admin", password: "password", role: "admin")
normaluser = User.create(email: "user@user.example", username: "user", password: "password")

mychar = Charity.create(name: "Feed Lam")

Person.create(firstname: "Joe", lastname: "Bloggs", dob: "2015/01/01")
dd = Person.create(firstname: "Dead", lastname: "Dude", dob: "1920/01/01", died: "1965/03/25")

mychar.people << dd
Memory.create(title: "My First Memory", story: "Once upon a time...", ranking: 2, user_id: admin.id)

["Home", "Town", "Restaurant or Bar", "Areena", "Sports Hall or Stadium", "Landmark", "Countryside"].each do |placetype|
	Placetype.create(placetype: "#{placetype}")
end

Pet.create(name: "Bob")
pub = Place.create(name: "The Pub")
pub.placetype = Placetype.first
pub.save

20.times do 
	Charity.create(name: Faker::Company.name)
end

100.times do 
	mem = Memory.create(title: Faker::App.name, story: Faker::Lorem.paragraph(2, false, 4), ranking: 1, user_id: admin.id)
end

spec = ['dog', 'cat', 'bird', 'rodent','fish', 'reptile', 'other']
spec.each do |species|
  Species.create(name: species)
end

50.times do |i|
  if rand(10) >= 5 
    p = Person.create(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, dob: Faker::Date.between(200.years.ago, Date.today))
  else
    born = Faker::Date.between(200.years.ago, Date.today)
    charity = Charity.limit(1).order("RANDOM()")[0]
    p = Person.create(firstname: Faker::Name.first_name, middlenames: "The #{Faker::Name.title}", lastname: Faker::Name.last_name, dob: born, died: Faker::Date.between(born, Date.today))
  	p.charity = charity
  end
  mem = Memory.limit(rand(3)).order("RANDOM()")
  p.memories << mem
end

50.times do
	born = Faker::Date.between(200.years.ago, Date.today)
	spec = Species.limit(1).order("RANDOM()")[0]
	pet = Pet.create(name: Faker::Name.first_name, dob: born, died: Faker::Date.between(born, Date.today))
	pet.species = spec
	pet.save
end

50.times do
	ptid = Placetype.limit(1).order("RANDOM()")[0].id
	lat = Faker::Address.latitude
	lng = Faker::Address.longitude
	Place.create(name: Faker::Company.name, placetype_id: ptid, address: Faker::Address.street_address, lat: "#{lat}", lng: "#{lng}")
end

20.times do
	if rand(10) >= 5
		Occasion.create(date: Faker::Date.between(100.years.ago, Date.today), name: Faker::Lorem.word)
	else
		date = Faker::Time.between(100.years.ago, Date.today)
		Occasion.create(date: date, time: date, name: Faker::Lorem.word)
	end
end

200.times do
	g = Group.new
	g.name = Faker::Lorem.word
	g.about = Faker::Lorem.sentences

	ppl = Person.limit(rand(3)).order("RANDOM()")
	plc = Place.limit(rand(3)).order("RANDOM()")
	occ = Occasion.limit(rand(3)).order("RANDOM()")
	pet = Pet.limit(rand(3)).order("RANDOM()")

	g.people << ppl unless ppl==nil
	g.places << plc unless plc==nil
	g.occasions << occ unless occ==nil
	g.pets << pet unless pet ==nil
	g.save
end