class User < ActiveRecord::Base
  devise :database_authenticatable, :lockable, :recoverable,
         :rememberable, :registerable, :timeoutable, :validatable,
         :token_authenticatable

  attr_accessible :email, :password, :password_confirmation, :freeswitch_id, :freeswitch_password
end
