class AddNameToAdminsMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :admins_messages, :name, :string
  end
end
