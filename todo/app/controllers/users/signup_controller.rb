class Users::SignupController < ApplicationController
  
  def new
    @user_model = User.new
  end
  
  def create
    @user_model = User.new
    @result = @user_model.add(user_params)
    if @result[:success]
      session[:user_id] = @result[:data].id
      flash[:success]   = UserConfig::FLASH[:account_ok]
      redirect_to root_path
    else
      @user_model = @result[:data]
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
