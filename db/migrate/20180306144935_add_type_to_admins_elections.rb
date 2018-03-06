class AddTypeToAdminsElections < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_elections, :type, :integer
  end
end
