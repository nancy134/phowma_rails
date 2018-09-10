class AddVotingToAdminsStates < ActiveRecord::Migration[5.2]
  def change
    add_column :admins_states, :voting, :string
  end
end
