json.extract! complaint, :id, :status, :title, :description, :created_at, :updated_at
json.creator do
  json.partial! 'api/v1/users/user', user: complaint.creator
end
