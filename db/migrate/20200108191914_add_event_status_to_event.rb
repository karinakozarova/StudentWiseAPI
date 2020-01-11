class AddEventStatusToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :event_status, :string, null: false, default: 'pending'
  end
end
