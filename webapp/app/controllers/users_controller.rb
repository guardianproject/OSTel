class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:link, :show, :update, :delete, :create, :edit]

  def suggest
    @user = User.new(params[:user])
    sip_username = @user.email.split("@").first
    if ( ! User.find_by_sip_username(sip_username))
      @suggestions = [sip_username]
    else
      @suggestions = @user.create_suggestions 
    end
  end

  def link
    # link account to third-party authentication services
  end

  def show
    @user = User.find(current_user.id)
    if ( @user.sip_username.nil? )
      redirect_to users_suggest_path
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if (@user.save)
      redirect_to @user
    else
      redirect_to users_suggest_path, :flash => { :user_unavailable => "The username #{params[:user][:sip_username]} is not available"}
    end
  end
end
