present(expense, V1::ExpensePresenter) do |e|
  json.expense do
    json.archived e.archived if e.archived_changed?
    json.updated_at e.updated_at
  end
end
