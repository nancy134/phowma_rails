class AddLongitude1ToAdminsDistrict < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_districts, :longitude1, :decimal
  end
end
