present(complaint, V1::ComplaintPresenter) do |c|
  json.complaint do
    json.status c.status if c.status_changed?
    json.locked c.locked? if c.locked_changed?
    json.updated_at c.updated_at
  end
end
