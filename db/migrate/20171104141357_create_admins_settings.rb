class CreateAdminsSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :admins_settings do |t|
      t.string :facebook_token

      t.timestamps
    end
  end
end
