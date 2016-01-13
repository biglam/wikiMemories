json.array!(@pets) do |pet|
  json.extract! pet, :id, :name, :dob, :dod
  json.url pet_url(pet, format: :json)
end
