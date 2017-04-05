class AddDistrictIdToAdminsElection < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_elections, :district_id, :integer
    add_index :admins_elections, :district_id
  end
end
