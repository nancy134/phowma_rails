class AddPoliticianToAdminsElections < ActiveRecord::Migration[5.0]
  def change
    add_reference :admins_elections, :politician, foreign_key: true
  end
end
