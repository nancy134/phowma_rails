class AddSocialDateToAdminsPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_posts, :social_date, :datetime
  end
end
