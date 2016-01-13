json.array!(@occasions) do |occasion|
  json.extract! occasion, :id, :name, :date, :time
  json.url occasion_url(occasion, format: :json)
end
