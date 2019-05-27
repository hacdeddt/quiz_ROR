# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    generic_callback( 'facebook' )
  end

  def google_oauth2
    generic_callback( 'google_oauth2' )
  end

  def generic_callback( provider )
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      # This is because we've created the user manually, and Device expects a
      # FormUser class (with the validations)
      if @user.banned
        respond_to do |format|
          format.html { redirect_to new_user_session_path, alert: "Tài khoản của bạn đã bị cấm"}
        end
      else
        sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
      end
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
