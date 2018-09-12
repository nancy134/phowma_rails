class AddEmailToAdminsMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :admins_messages, :email, :string
  end
end
