present(event, V1::EventPresenter) do |e|
  json.event do
    json.event_status e.event_status if e.event_status_changed?
    json.locked e.locked? if e.locked_changed?
  end
end
