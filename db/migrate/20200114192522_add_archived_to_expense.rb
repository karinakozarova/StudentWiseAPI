class AddArchivedToExpense < ActiveRecord::Migration[6.0]
  def change
    add_column :expenses, :archived, :boolean, default: false
  end
end
