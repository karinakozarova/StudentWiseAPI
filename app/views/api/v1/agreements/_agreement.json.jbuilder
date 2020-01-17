json.extract! agreement, :id, :title, :description, :created_at, :updated_at
json.group do
  json.partial! 'api/v1/groups/group', group: agreement.group
end
json.creator do
  json.partial! 'api/v1/users/user', user: agreement.creator
end
