class CreateAdminsElectionResults < ActiveRecord::Migration[5.0]
  def change
    create_table :admins_election_results do |t|
      t.integer :party
      t.integer :election_id
      t.integer :state_id

      t.timestamps
    end
    add_index :admins_election_results, :election_id
    add_index :admins_election_results, :state_id
  end
end
