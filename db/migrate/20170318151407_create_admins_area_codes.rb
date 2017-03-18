class CreateAdminsAreaCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :admins_area_codes do |t|
      t.string :code
      t.integer :state_id

      t.timestamps
    end
    add_index :admins_area_codes, :state_id
  end
end
