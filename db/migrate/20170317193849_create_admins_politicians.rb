class CreateAdminsPoliticians < ActiveRecord::Migration[5.0]
  def change
    create_table :admins_politicians do |t|
      t.string :name
      t.integer :party
      t.integer :state_id

      t.timestamps
    end
    add_index :admins_politicians, :state_id
  end
end
