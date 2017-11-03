class AddTwitterToAdminsPoliticians < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_politicians, :twitter, :string
  end
end
