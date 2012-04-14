class User < ActiveRecord::Base
  attr_accessible :email, :login, :name, :password, :pgpkey
end
