class AddLatestSocialToAdminsPoliticians < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_politicians, :latest_social, :datetime
  end
end
