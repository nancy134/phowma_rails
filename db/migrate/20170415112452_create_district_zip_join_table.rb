class CreateDistrictZipJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :districts, :zips, table_name: 'admins_districts_zips' do |t|
      t.index :district_id
      t.index :zip_id
    end
  end
end
