class AddLatitude2ToAdminsDistrict < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_districts, :latitude2, :decimal
  end
end
