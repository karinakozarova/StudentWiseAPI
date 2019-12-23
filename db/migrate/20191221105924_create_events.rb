class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :creator, foreign_key: { to_table: :users }
      t.string :event_type, default: 'other'
      t.string :title, null: false, default: ''
      t.text :description, default: ''
      t.datetime :starts_at
      t.datetime :finishes_at

      t.timestamps null: false
    end
  end
end
