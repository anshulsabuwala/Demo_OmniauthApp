class AddAttachmentContactPersonPhotoToManagers < ActiveRecord::Migration
  def self.up
    change_table :managers do |t|
      t.attachment :contact_person_photo
    end
  end

  def self.down
    remove_attachment :managers, :contact_person_photo
  end
end
