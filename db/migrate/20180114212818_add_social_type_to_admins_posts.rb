class AddSocialTypeToAdminsPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_posts, :social_type, :integer
  end
end
