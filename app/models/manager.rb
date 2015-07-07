require 'open-uri'

class Manager < ActiveRecord::Base
  has_one :user, as: :role, dependent: :nullify

  accepts_nested_attributes_for :user

  attr_accessor :contact_person_image_url

  has_attached_file :contact_person_photo,
    :path => ":rails_root/public/resources/contact/:id/:filename",
    :url  => "/resources/contact/:id/:filename"

  validates_presence_of :company_name
  validates_presence_of :phone_number
  #validates_presence_of :street
  #validates_presence_of :city
  #validates_presence_of :postal_code
  #validates_presence_of :state
  #validates_presence_of :country
  #validates_presence_of :occupation
  #validates_presence_of :page_url
  validates_presence_of :estate_agent
  validates_presence_of :verify_properties
  validates_presence_of :contact_person_full_name
  validates_presence_of :contact_person_email_address
  #validates_presence_of :contact_person_occupation
  validates_presence_of :contact_person_phone_number
  validates_presence_of :contact_person_position

  do_not_validate_attachment_file_type :contact_person_photo

  def contact_person_image_url=(image_url)
    return unless image_url.present?
    self.contact_person_photo = URI.parse(image_url)
  end
end
