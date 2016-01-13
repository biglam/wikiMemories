json.array!(@charities) do |charity|
  json.extract! charity, :id, :name, :justgiving_id
  json.url charity_url(charity, format: :json)
end
