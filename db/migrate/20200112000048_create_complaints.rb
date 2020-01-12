class CreateComplaints < ActiveRecord::Migration[6.0]
  def change
    create_table :complaints do |t|
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.string :status, null: false, default: 'sent'
      t.string :title, null: false
      t.text :description

      t.timestamps
    end
  end
end
