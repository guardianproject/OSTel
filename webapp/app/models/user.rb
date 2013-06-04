require 'sas_calculator'

class User < ActiveRecord::Base
  include SasCalculator

  devise :database_authenticatable, :lockable, :recoverable,
         :rememberable, :registerable, :timeoutable, :validatable,
         :token_authenticatable

  # accessable attributes for kam integration and account editing
  attr_accessible :email, :password, :ha1, :ha1b, :sip_username, :domain
  
  # callbacks for Kam integration
  before_create :generate_sip_hash
  before_update :generate_sip_hash

  # validations
  #
  # this validation should always happen
  validates :sip_username, :presence => true, :uniqueness => true, :unless => :update_username?,
                           :exclusion => {:in => %w(9196),
                           :message => "9196 is reserved, please choose another"}

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

  def update_username?
    # check to see if we are updating a sip_username for an existing user
    stored_user = User.find_by_sip_username self.sip_username
    # the id of the user is the same as me and sip_username hasn't been changed. skip validations.
    if ( stored_user.present?)
      stored_user.id == self.id && stored_user.sip_username == self.sip_username
    end
  end
end
