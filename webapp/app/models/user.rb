require 'sas_calculator'

class User < ActiveRecord::Base
  include SasCalculator

  devise :database_authenticatable, :lockable, :recoverable,
         :rememberable, :registerable, :timeoutable, :validatable,
         :token_authenticatable

  attr_accessible :email, :password, :ha1, :ha1b, :sip_username, :domain
  before_create :generate_sip_hash
  validates :sip_username, :uniqueness => true,
                           :presence => true,
                           :exclusion => {:in => %w(9196),
                           :message => "is reserved, please choose another"}

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
    domain = Devise::Application.config.domain
    self.ha1 = Digest::MD5.hexdigest("#{self.sip_username}:#{domain}:#{self.password}")
    self.ha1b = Digest::MD5.hexdigest("#{self.sip_username}@#{domain}:#{domain}:#{self.password}")
    self.domain = domain
  end
end
