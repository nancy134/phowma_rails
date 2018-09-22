class AddTwitterBioToAdminsPoliticians < ActiveRecord::Migration[5.2]
  def change
    add_column :admins_politicians, :twitter_bio, :string
  end
end
