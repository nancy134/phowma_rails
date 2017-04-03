class CreateAdminsDistricts < ActiveRecord::Migration[5.0]
  def change
    create_table :admins_districts do |t|
      t.string :name
      t.integer :state_id

      t.timestamps
    end
    add_index :admins_districts, :state_id
  end
end
