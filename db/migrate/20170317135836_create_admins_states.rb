class CreateAdminsStates < ActiveRecord::Migration[5.0]
  def change
    create_table :admins_states do |t|
      t.string :name
      t.string :abbreviation

      t.timestamps
    end
  end
end
