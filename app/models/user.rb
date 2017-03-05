class User < ApplicationRecord

  validates_presence_of :email, message: "Please enter email for the user"
  validates_uniqueness_of :email, message: "The user with this email has already registered"

  has_one :committee

  has_many :volunteers
  has_many :events, through: :volunteers

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  before_create :default_values

  def default_values
    if(self.is_super_admin?)
      self.is_member = false
      self.is_master_admin = false
    elsif (self.is_master_admin?)
      self.is_member = false
      self.is_super_admin = false
    else
      self.is_member = true
      self.is_super_admin = false
      self.is_master_admin = false
    end
    self.has_access = true if self.has_access.nil?
  end

  def username
    self.name ? self.name : self.email
  end
end