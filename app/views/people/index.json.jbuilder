json.array!(@people) do |person|
  json.extract! person, :id, :firstname, :middlenames, :lastname, :dob, :died, :charity_id
  json.url person_url(person, format: :json)
end
