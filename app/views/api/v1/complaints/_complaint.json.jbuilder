json.extract! complaint, :id, :status
json.locked complaint.locked?
json.extract! complaint, :title, :description, :created_at, :updated_at
json.group do
  json.partial! 'api/v1/groups/group', group: complaint.group
end
json.creator do
  json.partial! 'api/v1/users/user', user: complaint.creator
end
