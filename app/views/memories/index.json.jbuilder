json.array!(@memories) do |memory|
  json.extract! memory, :id, :title, :story, :ranking, :user_id
  json.url memory_url(memory, format: :json)
end
