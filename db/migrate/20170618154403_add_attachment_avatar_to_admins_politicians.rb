class AddAttachmentAvatarToAdminsPoliticians < ActiveRecord::Migration
  def self.up
    change_table :admins_politicians do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :admins_politicians, :avatar
  end
end
