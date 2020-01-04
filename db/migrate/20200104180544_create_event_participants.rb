class CreateEventParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :event_participants do |t|
      t.references :event, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :event_participants, [:event_id, :participant_id], unique: true
  end
end
