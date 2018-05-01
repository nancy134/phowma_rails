class AddLatitude1ToAdminsDistrict < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_districts, :latitude1, :decimal
  end
end
