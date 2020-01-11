class CreateEventVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :event_votes do |t|
      t.references :event, null: false, foreign_key: true
      t.references :voter, null: false, foreign_key: { to_table: :users }
      t.boolean :finished, null: false

      t.timestamps
    end

    add_index :event_votes, [:event_id, :voter_id], unique: true
  end
end
