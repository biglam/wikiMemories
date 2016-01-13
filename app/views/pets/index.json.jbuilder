json.array!(@pets) do |pet|
  json.extract! pet, :id, :name, :dob, :died
  json.url pet_url(pet, format: :json)
end
