class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :token

  def index
  end

  def about
  end

  def privacy
  end

  def token
  end
end
