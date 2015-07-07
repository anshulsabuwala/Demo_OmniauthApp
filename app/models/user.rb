require "open-uri"

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessor :avatar_image_url

  validates_presence_of :username
  validates_presence_of :account_type
  validates_uniqueness_of :email, :message => "Email address has already been taken"
  validates_confirmation_of :password, :message => 'Should match confirm password'
  validates_presence_of :password_confirmation


  before_validation :set_default_username, :on => :create

  belongs_to :role, :dependent => :destroy, :polymorphic => true
  has_many :authorizations

  has_attached_file :avatar,
    :path => ":rails_root/public/resources/user/:id/:filename",
    :url  => "/resources/user/:id/:filename"


  do_not_validate_attachment_file_type :avatar

  def avatar_image_url=(image_url)
    return unless image_url.present?
    self.avatar = URI.parse(image_url)
  end

  def self.from_omniauth(auth, current_user, user_type)
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s, :token => auth.credentials.token, :secret => auth.credentials.secret).first_or_initialize
    unless authorization.user.present?
      if auth.provider == "twitter"
        user = current_user || User.where('username = ?', auth.info.nickname).first
      else
        user = current_user || User.where('email = ?', auth["info"]["email"]).first
      end
      unless user.present?
        user = User.new
        user.account_type = 'basic'
        user.password = Devise.friendly_token[0,6]
        user.username = auth.info.nickname
        user.avatar = process_uri(auth.info.image)
        if auth.provider == "twitter"
          user.email = auth.info.nickname
          user.avatar = auth.info.image
          user.save(:validate => false)
        else
          user.email = auth.info.email
          user.save
        end
        extraInfo = auth["extra"]["raw_info"]
        if user_type.present?
          if user_type == "landlord"
            landlord = Landlord.new
            landlord.full_name = auth.info.name
            landlord.gender = extraInfo.gender
            landlord.user = user
            landlord.user_id = user.id
            landlord.save(:validate => false)            
          end
        else
          tenant = Tenant.new
          tenant.full_name = auth.info.name
          tenant.gender = extraInfo.gender
          tenant.user = user
          tenant.user_id = user.id
          tenant.save(:validate => false)
        end
      end
      authorization.username = auth.info.nickname
      authorization.user_id = user.id
      authorization.save
    end
    authorization.user
  end

  private

  def self.process_uri(uri)
    avatar_url = URI.parse(uri)
    avatar_url.scheme = 'https'
    avatar_url.to_s
  end

  def set_default_username
    tmp_username = "#{self.email.split('@')[0]}".gsub(/\s+/, "").to_s.downcase
    iterator = User.where({:username => tmp_username}).count
    tmp_username += iterator.to_s if iterator > 0 #append count where there are similar usernames
    self.username = tmp_username
  end
end
