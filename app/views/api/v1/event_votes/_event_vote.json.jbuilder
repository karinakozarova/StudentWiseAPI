present(event_vote, V1::EventVotePresenter) do |ev|
  json.extract! ev, :id, :event_id, :voter_id, :finished, :created_at, :updated_at
  if ev.event_status_changed?
    json.event do
      json.event_status ev.event.event_status
    end
  end
end
