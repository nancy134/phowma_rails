class CreateAdminsOffices < ActiveRecord::Migration[5.0]
  def change
    create_table :admins_offices do |t|
      t.integer :position
      t.integer :state_id
      t.integer :district_id
      t.integer :politician_id

      t.timestamps
    end
    add_index :admins_offices, :state_id
    add_index :admins_offices, :district_id
    add_index :admins_offices, :politician_id
  end
end
