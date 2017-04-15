class CreateAdminsZips < ActiveRecord::Migration[5.0]
  def change
    create_table :admins_zips do |t|
      t.integer :code

      t.timestamps
    end
    add_index :admins_zips, :code
  end
end
