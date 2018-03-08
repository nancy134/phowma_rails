class CreateAdminsCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :admins_campaigns do |t|
      t.integer :politician_id
      t.integer :election_id

      t.timestamps
    end
  end
end
