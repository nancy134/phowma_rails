class AddNumberToAdminsDistrict < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_districts, :number, :integer
  end
end
