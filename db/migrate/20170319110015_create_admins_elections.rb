class CreateAdminsElections < ActiveRecord::Migration[5.0]
  def change
    create_table :admins_elections do |t|
      t.integer :position
      t.integer :year

      t.timestamps
    end
  end
end
