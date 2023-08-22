class ApplicationController < ActionController::Base
  before_action :set_current_user, :get_session
    
  def set_current_user
    if session[SessionConfig::NAMES[:user_id]]
      @user_model = User.new
      @user_model.current_user(session[SessionConfig::NAMES[:user_id]])
    end
  end
  
  def get_session
    return {
      USER_ID: session[:user_id]
    }
  end
  
end
