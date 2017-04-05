class AddStateIdToAdminsElection < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_elections, :state_id, :integer
    add_index :admins_elections, :state_id
  end
end
