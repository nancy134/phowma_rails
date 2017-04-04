class AddDistrictIdToAdminsPolitician < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_politicians, :district_id, :integer
    add_index :admins_politicians, :district_id
  end
end
