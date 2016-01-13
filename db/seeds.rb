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

admin = User.create(email: "admin@admin.example", username: "admin", password: "password", role: "admin")
normaluser = User.create(email: "user@user.example", username: "user", password: "password")

Person.create(firstname: "Joe", lastname: "Bloggs", dob: "2015/01/01")

["Home", "Town", "Restaurant or Bar", "Areena", "Sports Hall or Stadium", "Landmark", "Countryside"].each do |placetype|
	Placetype.create(placetype: "#{placetype}")
end