present(user, V1::UserPresenter) do |u|
  json.user do
    json.updated_at u.updated_at
    if u.group_changed?
      json.group do
        json.partial! 'api/v1/groups/group', group: user.group
      end
    end
  end
end
