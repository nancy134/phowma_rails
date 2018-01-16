class AddPoliticianIdToAdminsPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_posts, :politician_id, :integer
    add_index :admins_posts, :politician_id
  end
end
