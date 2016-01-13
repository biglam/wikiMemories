json.array!(@places) do |place|
  json.extract! place, :id, :name, :placetype, :lat, :lng
  json.url place_url(place, format: :json)
end
