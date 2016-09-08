class AddTokenTimestampToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :token_timestamp, :timestamp
  end
end
