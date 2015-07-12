json.array!(@requests) do |request|
  json.extract! request, :id, :requestType, :created, :expires, :longtitude, :latitude
  json.url request_url(request, format: :json)
end
