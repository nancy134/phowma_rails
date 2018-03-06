class RenameTypeToElectionType < ActiveRecord::Migration[5.0]
  def change
    rename_column :admins_elections, :type, :election_type
  end
end
