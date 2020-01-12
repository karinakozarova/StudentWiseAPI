class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.string :notes
      t.decimal :price, null: false, precision: 8, scale: 2
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
