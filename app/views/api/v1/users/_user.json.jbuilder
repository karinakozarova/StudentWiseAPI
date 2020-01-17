present(user, V1::UserPresenter) do |u|
  if u.privileged?
    json.extract! u, :id, :email, :first_name, :last_name, :admin, :created_at, :updated_at
  else
    json.extract! u, :id, :first_name, :last_name, :admin, :created_at
  end
  json.group do
    json.partial! 'api/v1/groups/group', group: user.group
  end
end
