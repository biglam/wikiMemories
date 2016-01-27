FactoryGirl.define do
  factory :memory do
  title  Faker::Book.title
  story  Faker::Lorem.paragraph
  user_id 1
  end
end 