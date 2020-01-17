json.extract! event, :id, :kind, :status
json.locked event.locked?
json.extract! event, :title, :description, :starts_at, :finishes_at, :created_at, :updated_at
json.creator do
  json.partial! 'api/v1/users/user', user: event.creator
end
json.participants do
  json.array! event.participants, partial: 'api/v1/users/user', as: :user
end
json.votes do
  json.array! event.event_votes, partial: 'api/v1/event_votes/event_vote', as: :event_vote
end
