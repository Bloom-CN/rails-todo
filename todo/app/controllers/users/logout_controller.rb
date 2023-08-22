class Users::LogoutController < ApplicationController
  def destroy
    session[:user_id] = nil
    flash[:success]   = UserConfig::FLASH[:logout_ok]
    redirect_to login_path
  end
end
