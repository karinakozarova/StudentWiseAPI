json.extract! expense_participant, :id, :expense_id, :participant_id, :created_at, :updated_at
json.participant do
  json.partial! 'api/v1/users/user', user: expense_participant.participant
end
