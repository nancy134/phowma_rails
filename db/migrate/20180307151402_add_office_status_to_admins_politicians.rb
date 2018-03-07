class AddOfficeStatusToAdminsPoliticians < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_politicians, :office_status, :integer
  end
end
