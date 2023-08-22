class Users::LoginController < ApplicationController
  def new
    @user_model  = User.new
    @link_signup = LinkConfig::LINKS[:signup]
  end
  
  def create
    @user_model = User.new
    @user_data  = @user_model.login(params)
    
    if @user_data[:success]
      session[configs[:user_id]] = @user_data[:data].id
      flash[:success]            = configs[:success]
      redirect_to root_path
    else
      flash.now[:failed] = configs[:failed]
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def configs
    return {
      user_id: SessionConfig::NAMES[:user_id],
      success: UserConfig::FLASH[:login_ok],
      failed: UserConfig::FLASH[:login_failed]
    }
  end
  
end
