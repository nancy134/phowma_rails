class AddOfficeToAdminsElection < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_elections, :office_id, :integer
    add_index :admins_elections, :office_id
  end
end
