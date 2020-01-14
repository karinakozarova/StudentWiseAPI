json.extract! event_vote, :id, :event_id, :voter_id, :finished, :created_at, :updated_at
json.partial! 'api/v1/events/event_changes', event: event_vote.event
