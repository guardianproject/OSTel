class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :token

  def index
  end

  def token
  end
end
