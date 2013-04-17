require 'sas_calculator'

class User < ActiveRecord::Base
  include SasCalculator

  devise :database_authenticatable, :lockable, :recoverable,
         :rememberable, :registerable, :timeoutable, :validatable,
         :token_authenticatable

  attr_accessible :email, :password, :ha1, :ha1b, :sip_username, :domain
  before_save :generate_sip_hash
  validates :sip_username, :uniqueness => true

  def create_suggestions
    desired_username = self.email.split("@").first
    seed = desired_username.bytes.to_a.shuffle.first
    indexes = desired_username.bytes.to_a.shuffle(random: Random.new(seed))
    words = calculateSAS(indexes)
    suggestions = ["#{desired_username}-#{words[0]}",
                  "#{desired_username}-#{words[1]}",
                  "#{words[0]}-#{desired_username}",
                  "#{words[1]}-#{desired_username}"]
    return suggestions
  end

  protected
  def generate_sip_hash
    self.ha1 = Digest::MD5.hexdigest("#{self.sip_username}:#{self.password}:#{Devise::Application.config.domain}")
    self.ha1b = Digest::MD5.hexdigest("#{self.sip_username}@#{Devise::Application.config.domain}:#{self.password}:#{Devise::Application.config.domain}")
    self.domain = Devise::Application.config.domain
  end
end
