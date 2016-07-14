class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      flash.notice = "Signed in!"
      @user.skip_confirmation!
      @user.save!
      @user
      sign_in_and_redirect (@user)
    #  sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      #set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to finish_signup_path
    end
  end

  def after_sign_up_path_for(resource)
    return finish_signup_path
  end

  def after_inactive_sign_up_path_for(resource)
    return finish_signup_path
  end

  def failure
    redirect_to root_path
  end
end
