# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def authsider
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    logger.info "loggin in"


    if @user.persisted?
    sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
    set_flash_message(:notice, :success, kind: 'Authsider') if is_navigational_format?

    else
      session['devise.authsider_data'] = request.env['omniauth.auth']
      redirect_to root_path
    end
  end

  def failure
    logger.info 'failure'
    redirect_to root_path
  end
end
