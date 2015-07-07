class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :title
      t.string :full_name
      t.string :gender
      t.date :date_of_birth
      t.string :address_type
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :country
      t.string :occupation
      t.text :brief_description

      t.timestamps null: false
    end
  end
end
