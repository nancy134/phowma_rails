class CreateAdminsMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :admins_messages do |t|

      t.timestamps
    end
  end
end
