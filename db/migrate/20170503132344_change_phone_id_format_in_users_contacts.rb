class ChangePhoneIdFormatInUsersContacts < ActiveRecord::Migration[5.0]
  def change
    change_column :users_contacts, :phone_id, :string
  end
end
