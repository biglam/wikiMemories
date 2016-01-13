# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Person.delete_all
Memory.delete_all
Place.delete_all
Placetype.delete_all
Pet.delete_all
Charity.delete_all

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
