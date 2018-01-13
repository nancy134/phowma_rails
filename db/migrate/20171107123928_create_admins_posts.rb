class CreateAdminsPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :admins_posts do |t|
      t.string :message
      t.string :image

      t.timestamps
    end
  end
end
