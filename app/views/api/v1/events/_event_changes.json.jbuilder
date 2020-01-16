present(event, V1::EventPresenter) do |e|
  json.event do
    json.status e.status if e.status_changed?
    json.locked e.locked? if e.locked_changed?
  end
end
