class AddLongitude2ToAdminsDistrict < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_districts, :longitude2, :decimal
  end
end
