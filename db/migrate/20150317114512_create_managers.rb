class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.string :company_name
      t.string :phone_number
      t.string :street
      t.string :city
      t.string :postal_code
      t.string :state
      t.string :country
      t.text :company_description
      t.string :occupation
      t.string :page_url
      t.string :add_page
      t.boolean :verify_properties
      t.string :estate_agent
      t.string :contact_person_full_name
      t.string :contact_person_email_address
      t.string :contact_person_occupation
      t.string :contact_person_phone_number
      t.string :contact_person_position
      t.string :contact_person_photo

      t.timestamps null: false
    end
  end
end
