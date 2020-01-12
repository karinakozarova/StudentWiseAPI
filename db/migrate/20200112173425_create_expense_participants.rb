class CreateExpenseParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :expense_participants do |t|
      t.references :expense, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :expense_participants, [:expense_id, :participant_id], unique: true
  end
end
