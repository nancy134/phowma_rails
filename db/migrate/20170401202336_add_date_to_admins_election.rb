class AddDateToAdminsElection < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_elections, :date, :date
  end
end
