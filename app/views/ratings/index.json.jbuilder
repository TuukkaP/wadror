json.array!(@ratings) do |rating|
  json.extract! rating, :id, :score
  json.user do
    json.name rating.user.username
  end
end