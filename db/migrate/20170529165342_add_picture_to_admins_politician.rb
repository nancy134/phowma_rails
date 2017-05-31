class AddPictureToAdminsPolitician < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_politicians, :picture, :string
  end
end
