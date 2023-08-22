class Users::ListController < ApplicationController
  
  def index
    @user_model = User.new
    @user_list  = @user_model.list
  end
  
  
end
