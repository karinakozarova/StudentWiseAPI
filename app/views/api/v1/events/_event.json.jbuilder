json.extract! event, :id, :event_type, :title, :description, :starts_at, :finishes_at, :created_at, :updated_at
json.creator do
  json.partial! 'api/v1/users/user', user: event.creator
end
json.participants do
  json.array! event.participants, partial: 'api/v1/users/user', as: :user
end
