json.extract! agreement, :id, :title, :description, :created_at, :updated_at
json.creator do
  json.partial! 'api/v1/users/user', user: agreement.creator
end
