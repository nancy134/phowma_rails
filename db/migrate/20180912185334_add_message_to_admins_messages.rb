class AddMessageToAdminsMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :admins_messages, :message, :string
  end
end
