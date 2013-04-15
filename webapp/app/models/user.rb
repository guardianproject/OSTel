class User < ActiveRecord::Base
  devise :database_authenticatable, :lockable, :recoverable,
         :rememberable, :registerable, :timeoutable, :validatable,
         :token_authenticatable

  attr_accessible :email, :password, :password_confirmation, :ha1, :ha1b, :username
  before_create :generate_sip_hash

  protected
  def generate_sip_hash
    self.ha1 = Digest::MD5.hexdigest("#{self.username}:#{self.password}:#{Devise::Application.config.domain}")
    self.ha1b = Digest::MD5.hexdigest("#{self.username}@#{Devise::Application.config.domain}:#{self.password}:#{Devise::Application.config.domain}")
  end
end
