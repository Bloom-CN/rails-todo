class Users::IndexController < ApplicationController
  DETAIL_LINK = LinkConfig::LINKS[:user_detail] + "/"
  EDIT_LINK   = LinkConfig::LINKS[:user_edit] + "/"
  
  def index
    @user_model  = User.new
    @user_list   = @user_model.list
    @link_detail = DETAIL_LINK
  end
  
  def new
    @user_model  = User.new
  end
  
  def show
    @link_edit = EDIT_LINK + params[:id]
    
    @user_model  = User.new
    @user_detail = @user_model.detail(params[:id])
  end
  
  def edit
    @user_model  = User.new
    @user_detail = @user_model.detail(params[:id])
  end
  
  def update
    @user_model  = User.new
    @user_detail = @user_model.detail(params[:id])
    @update_user = @user_model.edit(edit_params)
    
    if @update_user
      flash[configs[:success]] = configs[:success_text]
      redirect_to action: :show
    else
      flash.now[configs[:failed]] = configs[:failed_text]
      render :edit, status: :unprocessable_entity
    end
  end
  
  def delete
    @user_model  = User.new
    @user_list   = @user_model.list
    @link_detail = DETAIL_LINK
    
    if @user_model.del(params[:id])
      flash[configs[:success]] = configs[:delete_success_text]
      redirect_to action: :index
    else
      flash.now[configs[:failed]] = configs[:delete_failed_text]
      render :index, status: :unprocessable_entity
    end
    
  end
  
  private
  
  def  edit_params
    params.require(:user).permit(:id, :name, :email)
  end
  
  def configs
    return {
      # ステータス
      success: SessionConfig::NAMES[:success],
      failed: SessionConfig::NAMES[:failed],
      
      # ステータステキスト
      success_text: UserConfig::FLASH[:account_edit_success],
      failed_text: UserConfig::FLASH[:account_edit_failed],
      delete_success_text: UserConfig::FLASH[:account_delete_success],
      delete_failed_text: UserConfig::FLASH[:account_delete_failed],
    }
  end
  
end
