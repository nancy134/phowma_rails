class AddFacebookToAdminsPoliticians < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_politicians, :facebook, :string
  end
end
