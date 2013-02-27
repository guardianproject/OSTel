class Admin < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :timeoutable, :validatable,
         :timeout_in => 20.minutes
end
