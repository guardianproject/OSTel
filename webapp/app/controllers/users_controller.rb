class UsersController < ApplicationController
  def suggest
    @user = User.find(current_user.id)
    sip_username = @user.email.split("@")
    if ( ! User.find_by_sip_username(sip_username))
      @suggestions = [sip_username.first]
    else
      @suggestions = User.create_suggestions 
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

  def edit

  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if (@user.save)
      redirect_to @user
    end
  end

  def delete

  end
end
