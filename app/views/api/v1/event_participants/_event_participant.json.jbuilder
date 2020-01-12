json.extract! event_participant, :id, :event_id, :participant_id, :created_at, :updated_at
json.participant do
  json.partial! 'api/v1/users/user', user: event_participant.participant
end
