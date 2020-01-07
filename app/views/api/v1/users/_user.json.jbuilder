present(user, V1::UserPresenter) do |u|
  if u.privileged?
    json.extract! u, :id, :email, :first_name, :last_name, :created_at, :updated_at
  else
    json.extract! u, :id, :first_name, :last_name, :created_at
  end
end
