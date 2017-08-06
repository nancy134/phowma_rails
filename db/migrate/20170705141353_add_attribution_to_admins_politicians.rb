class AddAttributionToAdminsPoliticians < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_politicians, :attribution, :string
  end
end
