class AddFirstNameToAdminsPolitician < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_politicians, :first_name, :string
    add_column :admins_politicians, :last_name, :string
  end
end
