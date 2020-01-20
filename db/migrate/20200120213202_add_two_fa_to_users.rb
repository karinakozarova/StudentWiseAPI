class AddTwoFaToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :two_fa_enabled, :boolean, default: false
    add_column :users, :two_fa_secret, :string
    add_column :users, :two_fa_challenge, :string
  end
end
