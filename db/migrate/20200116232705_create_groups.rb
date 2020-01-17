class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :description
      t.text :rules

      t.timestamps
    end

    add_index :groups, :name, unique: true

    add_reference :agreements, :group, null: false, foreign_key: true
    add_reference :complaints, :group, null: false, foreign_key: true
    add_reference :events, :group, null: false, foreign_key: true
    add_reference :expenses, :group, null: false, foreign_key: true
    add_reference :users, :group, foreign_key: true
  end
end
