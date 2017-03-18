class AddPositionToAdminsPolitician < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_politicians, :position, :integer
  end
end
