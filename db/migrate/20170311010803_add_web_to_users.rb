class AddWebToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :web, :boolean
  end
end
