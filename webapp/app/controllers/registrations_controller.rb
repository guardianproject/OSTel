class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def suggest
    @user = User.new(params[:user])
    sip_username = @user.email.split("@").first
    if ( ! User.find_by_sip_username(sip_username))
      @suggestions = [sip_username]
    else
      @suggestions = @user.create_suggestions 
    end
  end

  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      respond_with resource, :location => registrations_suggest_path_for(resource)
    end
  end

  def update
    super
  end
end
