present(expense, V1::ExpensePresenter) do |e|
  json.expense do
    json.archived e.archived if e.archived_changed?
  end
end
