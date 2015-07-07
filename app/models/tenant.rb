class Tenant < ActiveRecord::Base
  has_one :user, as: :role, dependent: :nullify

  accepts_nested_attributes_for :user

  validates_presence_of :title
  validates_presence_of :full_name
  validates_presence_of :gender
  validates_presence_of :date_of_birth
  validates_presence_of :address_type
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :postal_code
  validates_presence_of :country
  validates_presence_of :occupation
end
