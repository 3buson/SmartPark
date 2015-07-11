json.array!(@users) do |user|
  json.extract! user, :id, :username, :password, :number, :credits, :cash, :reputation, :requested, :received, :voteUp, :voteDown
  json.url user_url(user, format: :json)
end
