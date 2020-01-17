class AddStatusToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :status, :string, null: false, default: 'pending'
  end
end
