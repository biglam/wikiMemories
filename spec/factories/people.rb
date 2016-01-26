FactoryGirl.define do
	factory :person do
	firstname  Faker::Name.first_name
	middlenames  Faker::Name.name
	lastname  Faker::Name.last_name
	dob  Faker::Date.between(200.years.ago, Date.yesterday)
	dob = dob
	died  Date.today
	place_of_birth  Faker::Address.city
	died_of  Faker::Company.catch_phrase
	end
end	