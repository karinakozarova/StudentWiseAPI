present(expense, V1::ExpensePresenter) do |e|
  json.extract! e, :id, :name, :notes, :price, :quantity, :archived, :created_at, :updated_at
  json.creator do
    json.partial! 'api/v1/users/user', user: e.creator
  end
  json.participants do
    json.array! e.participants, partial: 'api/v1/users/user', as: :user
  end
end
