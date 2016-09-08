class AddTokenDateToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :token_date, :timestamp
  end
end
