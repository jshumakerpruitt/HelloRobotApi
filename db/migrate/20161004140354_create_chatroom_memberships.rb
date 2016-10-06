class CreateChatroomMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :chatroom_memberships do |t|
      t.references :user, foreign_key: true
      t.references :chatroom, foreign_key: true
      t.integer :partner_id, foreign_key: true

      t.timestamps
    end
  end
end
