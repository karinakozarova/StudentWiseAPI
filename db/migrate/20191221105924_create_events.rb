class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.string :kind, null: false, default: 'other'
      t.string :title, null: false
      t.text :description
      t.datetime :starts_at
      t.datetime :finishes_at

      t.timestamps
    end
  end
end
