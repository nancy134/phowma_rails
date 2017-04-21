class CreateUsersContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :users_contacts do |t|
      t.integer :phone_id

      t.timestamps
    end
    add_index :users_contacts, :phone_id
  end
end
