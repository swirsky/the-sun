json.array!(@users) do |user|
  json.extract! user, :id, :email, :firstname, :lastname, :username, :password
  json.url user_url(user, format: :json)
end
