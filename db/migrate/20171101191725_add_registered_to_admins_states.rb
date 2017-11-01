class AddRegisteredToAdminsStates < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_states, :registered, :string
  end
end
