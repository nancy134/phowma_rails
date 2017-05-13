class AddUserIdToUsersContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :users_contacts, :user_id, :integer
    add_index :users_contacts, :user_id
  end
end
