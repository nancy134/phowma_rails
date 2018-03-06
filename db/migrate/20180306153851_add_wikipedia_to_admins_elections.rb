class AddWikipediaToAdminsElections < ActiveRecord::Migration[5.0]
  def change
    add_column :admins_elections, :wikipedia, :string
  end
end
