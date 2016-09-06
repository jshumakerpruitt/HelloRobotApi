class CreateUserLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :user_likes do |t|
      t.integer :user_id
      t.integer :liked_user_id

      t.timestamps
    end
    add_foreign_key :user_likes, :users
    add_index :user_likes, :liked_user_id
  end
end
